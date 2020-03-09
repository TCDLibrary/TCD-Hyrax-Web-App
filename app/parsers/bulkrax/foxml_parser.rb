module Bulkrax
  class FoxmlParser < XmlParser
    def record_element
      'ROW'
    end

    def entry_class
      Bulkrax::FoxmlEntry
    end

    # Override bulkrax to move files to Bulkrax.import_path/importer_id/
    def valid_import?
      if parser_fields['import_file_path'].include?('public/data/ingest')
        move_import_files
        parser_fields['import_file_path'] = path_for_import
        importerexporter.save!
      end
      raise StandardError, 'No metadata files found' if metadata_paths.blank?
      raise StandardError, 'No records found' if records.blank?

      true
    rescue StandardError => e
      status_info(e)
      false
    end

    # Create collection objects for works only.
    # Although this sounds counter intuitive, we need Collection Entries only where they are works in order to create
    #   work-work relationships with create_parent_child_relationships
    def create_collections
      return if parser_fields['parent_id'].blank? || parent.blank?

      @parent = setup_parent_for_collection_entry
      raise StandardError, "problem setting #{Bulkrax.system_identifier_field} on parent #{parent.id}" if parent.send(Bulkrax.system_identifier_field).blank?

      new_entry = find_or_create_entry(collection_entry_class, parent.send(Bulkrax.system_identifier_field).first, 'Bulkrax::Importer')
      ImportWorkCollectionJob.perform_now(new_entry.id, current_importer_run.id)
      increment_counters(0, true)
    end

    # Override bulkrax method to create only work-work relationships
    def create_parent_child_relationships
      return if parser_fields['parent_id'].blank? || parent.blank? || parent.class == Collection

      parents = importerexporter.entries.select { |e| e.class == collection_entry_class }
      raise StandardError, "Could not find the Collection Entry for #{parent.id}" if parents.blank?

      parent_id = parents.first.id
      child_entry_ids = importerexporter.entries.map { |e| e.id if e.class == entry_class }.compact
      ChildRelationshipsJob.perform_later(parent_id, child_entry_ids, current_importer_run.id)
    end

    def collection_entry_class
      Bulkrax::FoxmlCollectionEntry
    end

    def parent
      @parent ||= ActiveFedora::Base.find(parser_fields['parent_id'])
    rescue StandardError
      nil
    end

    def setup_parent_for_collection_entry
      if parent.send(Bulkrax.system_identifier_field).blank?
        parent.send("#{Bulkrax.system_identifier_field}=", [parent.id])
        parent.save!
      end
      parent.reload
    end

    # Move contents of public/data/ingest to Bulkrax.import_path/importer_id
    def move_import_files
      # Gather the files
      files = if File.file?(parser_fields['import_file_path'])
                Dir.glob(
                  "#{File.dirname(parser_fields['import_file_path'])}/**/*"
                ).reject { |f| f.include?('public/data/ingest/HI') }
              else
                Dir.glob(
                  "#{parser_fields['import_file_path']}/**/*"
                ).reject { |f| f.include?('public/data/ingest/HI') }
              end
      raise 'No files found' if files.blank?

      # Move the files
      move_files(files)
    end

    # Move xml file from the base
    # The Project folder (containing the images)
    def move_files(files)
      files.each do |f|
        # when a whole dir has moved the files will no longer exist in their original position
        next unless File.exist?(f)

        # Use force to replace existing files with updated copies
        FileUtils.mv(f, File.join(path_for_import, File.basename(f)), force: true)
      end
    end
  end
end

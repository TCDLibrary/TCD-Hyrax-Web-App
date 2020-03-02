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
      Rails.logger.info('I AM HERE!!!')
      if parser_fields['import_file_path'].include?('public/data/ingest')
        move_import_files
        parser_fields['import_file_path'] = path_for_import
        importerexporter.save!
      end
      raise 'No metadata files found' if metadata_paths.blank?
      raise 'No records found' if records.blank?
      true
    rescue => e
      status_info(e)
      false
    end

    # Move contents of public/data/ingest to Bulkrax.import_path/importer_id
    def move_import_files
      # Gather the files
      files = if File.file?(parser_fields['import_file_path'])
                Dir.glob(
                  "#{File.dirname(parser_fields['import_file_path'])}/**/*"
                ).reject {|f| f.include?('public/data/ingest/HI')}
              else
                Dir.glob(
                  "#{parser_fields['import_file_path']}/**/*"
                ).reject {|f| f.include?('public/data/ingest/HI') }
              end
      raise "No files found" if files.blank?
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

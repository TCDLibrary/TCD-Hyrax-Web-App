# frozen_string_literal: true

module Bulkrax::HasLocalProcessing
  # This method is called during build_metadata
  # add any special processing here, for example to reset a metadata property
  # to add a custom property from outside of the import data
  def add_local
    self.parsed_metadata['keyword'] = ['Unassigned'] if self.parsed_metadata['keyword'].blank?
    self.parsed_metadata['creator'] = ['Unattributed'] if self.parsed_metadata['creator'].blank?
    self.parsed_metadata['file'] = image_paths
    self.parsed_metadata[Bulkrax.system_identifier_field] = [self.raw_metadata['source_identifier']]
    self.parsed_metadata['collections'] = [] unless parent_collection?
    cleanup_parent_work if parent? && !parent_collection?
  end

  def image_paths
    return [] if self.importerexporter.parser_fields['image_type'] == 'Not Now'
    image_full_paths.map do |path|
      Dir.glob(path)
    end.flatten.compact.uniq.sort
  end

  def image_full_paths
    image_type_subpaths.map do | image_type |
      if image_range.blank?
        File.join(image_base_path,image_folder,image_type,"#{image_id}*")
      else
        image_range.map {|range| 
          File.join(image_base_path,image_folder,image_type,"#{image_id}_#{range}_*") 
        }.flatten
      end
    end.flatten
  end

  def image_base_path
    self.importerexporter.parser_fields['import_file_path']
  end

  def image_id
    if self.importerexporter.parser_fields['import_type'] == 'multiple' && image_range.blank?
      record.xpath("//*[name()='DRISPhotoID']").first.content
    else
      record.xpath("//*[name()='CatNo']").first.content
    end
  end

  def image_range
    range_el = record.xpath("//*[name()='ImgRange']")
    return [] if range_el.blank?
    range = range_el.first.content.split(':')
    return (range[0]..range[1]).to_a
  end

  def image_folder
    folder = record.xpath("//*[name()='ProjectName']").first.content
    if image_base_path.include?(folder)
      return ''
    else
      return folder
    end
  end

  def image_type_subpaths
    case self.importerexporter.parser_fields['image_type']
    when 'HI'
      ['/HI/']
    when 'LO'
      ['/LO/']
    when 'TIF'
      ['/TIF/']
    when 'HI and TIFF'
      ['/TIF/', '/HI/']
    end
  end

  # override Bulkrax add_rights_statement with boilerplate
  def add_rights_statement
    self.parsed_metadata['rights_statement'] = [
      'Copyright The Board of Trinity College Dublin. Images are available for single-use academic application only. Publication, transmission or display is prohibited without formal written approval of the Library of Trinity College, Dublin.'
    ]
  end

  def cleanup_parent_work
    skip_fields.each do |field|
      next unless self.parsed_metadata[field].present?
      self.parsed_metadata[field].each do |val|
        self.parsed_metadata[field].delete(val) if parent_attributes[field].include?(val)
      end
    end
  end

  def skip_fields
    %w[
      creator_loc
      creator_local
      publisher
      location
      resource_type
      bibliography
      dris_page_no
      dris_document_no
      format_duration
      copyright_note
      digital_root_number
      digital_object_identifier
      location_type
      sponsor
      conservation_history
      publisher_location
      page_number
      page_type
      physical_extent
      keyword
      subject_local_keyword
      series_title
      county
      project_number
      order_no
      total_records
    ]
  end
end

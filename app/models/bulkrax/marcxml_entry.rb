module Bulkrax
  class MarcxmlEntry < XmlEntry
    def self.matcher_class
      Bulkrax::MarcxmlMatcher
    end

    # Override to gsub the following:
    # \u0096 => space
    # \u0092 => ’
    # \u0091 => ‘
    def self.data_for_entry(data, path = nil)
      collections = []
      children = []
      #byebug
      xpath_for_source_id = ".//*[name()='#{source_identifier_field}']"
      {
        source_identifier: data.xpath(xpath_for_source_id).first.text,
        data:
          data.to_xml(
            encoding: 'UTF-8',
            save_with:
              Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
          ).delete("\n").delete("\t").tr("\u0091", '‘').tr("\u0092", '’').tr("\u0096", ' '),
        collection: collections,
        file: record_file_paths(path),
        children: children
      }
    end

    def collections_created?
      return true if importerexporter.parser_fields['parent_id'].blank?
      return true unless find_or_create_collection_ids.blank?
    end

    def find_or_create_collection_ids
      self.collection_ids = [parent.id] if parent?
      collection_ids
    rescue StandardError
      []
    end

    def parent?
      !parent.blank?
    end

    def parent
      @parent ||= ActiveFedora::Base.find(importerexporter.parser_fields['parent_id'])
    rescue StandardError
      nil
    end

    def parent_attributes
      @parent_attributes ||= parent.attributes if parent?
    end

    def parent_collection?
      parent.is_a?(Collection)
    end

    def factory_class
      importerexporter.parser_fields['object_type'].constantize
    end
  end
end

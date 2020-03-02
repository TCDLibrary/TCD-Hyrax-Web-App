module Bulkrax
  class FoxmlEntry < XmlEntry
    def self.matcher_class
      Bulkrax::FoxmlMatcher
    end

    # Override to gsub the following:
    # \u0096 => space
    # \u0092 => ’
    # \u0091 => ‘
    def self.data_for_entry(data, path = nil)
      collections = []
      children = []
      xpath_for_source_id = ".//*[name()='#{source_identifier_field}']"
      return {
        source_identifier: data.xpath(xpath_for_source_id).first.text,
        data:
          data.to_xml(
            encoding: 'UTF-8',
            save_with:
              Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
          ).gsub("\n",'').gsub("\t", '').gsub("\u0091",'‘').gsub("\u0092",'’').gsub("\u0096",' '),
        collection: collections,
        file: record_file_paths(path),
        children: children
      }
    end

    # Override bulkrax to add parent handling
    def build_for_importer
      begin
        build_metadata
        unless self.importerexporter.validate_only
          raise CollectionsCreatedError unless collections_created?
          @item = factory.run
        end
      rescue RSolr::Error::Http, CollectionsCreatedError => e
        raise e
      rescue StandardError => e
        status_info(e)
      else
        status_info
      end
      return @item
    end

    def collections_created?
      return true if self.importerexporter.parser_fields['parent_id'].blank?
      return true unless find_or_create_collection_ids.blank?
    end

    def find_or_create_collection_ids
      self.collection_ids = [parent.id] if parent?
      return self.collection_ids
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
      self.importerexporter.parser_fields['object_type'].constantize
    end
  end
end

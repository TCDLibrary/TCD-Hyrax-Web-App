module Bulkrax
  class FoxmlEntry < XmlEntry
    def self.matcher_class
      Bulkrax::FoxmlMatcher
    end

    def build_for_importer
      begin
        build_metadata
        raise CollectionsCreatedError unless collections_created?
        @item = factory.run
        if parent? && !parent_collection?
          parent.members += [@item]
          parent.save
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

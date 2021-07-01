# frozen_string_literal: true
require 'tcd_metadata/mods_record'
require 'nokogiri'
module Bulkrax
  # Generic XML Entry
  class ModsEntry < Entry
    serialize :raw_metadata, JSON

    def self.fields_from_data(data); end


    # @param [String] path
    # @return [Nokogiri::XML::Document]
    def self.read_data(path)
      Nokogiri::XML(open(path)).remove_namespaces!
    end


    # @param [Nokogiri::XML::Element] data
    def self.data_for_entry(data)
      collections = []
      children = []
      xpath_for_source_id = ".//*[name()='#{source_identifier_field}']"
      return {
        source_identifier: data.xpath(xpath_for_source_id).first.text,
        data:
          data.document.to_xml(
            encoding: 'utf-8',
            save_with:
                Nokogiri::XML::Node::SaveOptions::DEFAULT_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
          ).delete("\n").delete("\t").tr("\u0091", '‘').tr("\u0092", '’').tr("\u0096", ' '),
        collection: collections,
        children: children
      }
    end

    def source_identifier
      @source_identifier ||= self.raw_metadata['source_identifier']
    end

    def record
    # JL: self.raw_metadata['data'] is the full XML file. So MODSRecord has to pull just the current recordIdentifier node
      @record ||= TcdMetadata::MODSRecord.new(source_identifier, self.raw_metadata['data'])
    end

    def files
      @files ||= record.files
    end

    def build_metadata
      raise StandardError, 'Record not found' if record.nil?
      raise StandardError, 'Missing source identifier' if source_identifier.blank?
      self.parsed_metadata = {}
      self.parsed_metadata['admin_set_id'] = self.importerexporter.admin_set_id
      self.parsed_metadata[Bulkrax.system_identifier_field] = [source_identifier]

      record.attributes.each do |k,v|
        add_metadata(k, v) unless v.blank?
      end
      add_title
      add_visibility
      add_rights_statement
      add_shelf_locator
      add_folder_number
      add_digital_root_number
      add_genre
      add_abstract
      add_local
      raise StandardError, "title is required" if record.title.blank?
      self.parsed_metadata
    end

    def add_title
      self.parsed_metadata['title'] = [record.title]
    end

    def add_shelf_locator
      self.parsed_metadata['shelfLocator'] = [record.shelfLocator]
    end

    def add_folder_number
      self.parsed_metadata['folder_number'] = [record.folder_number]
    end

    def add_digital_root_number
      self.parsed_metadata['digital_root_number'] = [record.digital_root_number]
    end

    def add_genre
      self.parsed_metadata['genre'] = [record.genre]
    end

    def add_abstract
      self.parsed_metadata['abstract'] = [record.abstract]
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

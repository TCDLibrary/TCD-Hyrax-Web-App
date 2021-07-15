# frozen_string_literal: true

require 'nokogiri'
module Bulkrax
  # Generic XML Entry
  class MetsXmlEntry < Entry
    serialize :raw_metadata, JSON

    def self.fields_from_data(data); end


    # @param [String] path
    # @return [Nokogiri::XML::Document]
    def self.read_data(path)
      # This doesn't cope with BOM sequences:
      # Nokogiri::XML(open(path), nil, 'UTF-8').remove_namespaces!
      Nokogiri::XML(open(path))
    end


    # @param [Nokogiri::XML::Element] data
    def self.data_for_entry(data)
      collections = []
      children = []
      #byebug
      source_identifier = data.attributes[source_identifier_field].text
      return {
        source_identifier: source_identifier,
        data:
          data.document.to_xml(
            encoding: 'utf-8',
            save_with:
                Nokogiri::XML::Node::SaveOptions::DEFAULT_XML
          ),
        collection: collections,
        children: children
      }
    end

    def source_identifier
      @source_identifier ||= self.raw_metadata['source_identifier']
    end

    def record
      @record ||= TcdMetadata::METSRecord.new(source_identifier, raw_metadata['data'])
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
      self.parsed_metadata['work_type'] = [parser.parser_fields['work_type'] || 'PagedResource']

      record.attributes.each do |k,v|
        add_metadata(k, v) unless v.blank?
      end
      add_title
      add_visibility
      add_rights_statement
      add_local_files
      add_remote_files
      add_logical_structure
      add_collections
      add_local
      raise StandardError, "title is required" if self.parsed_metadata['title'].join.blank?
      self.parsed_metadata
    end

    def add_title
      self.parsed_metadata['title'] = [parser.parser_fields['title'] || record.identifier]
    end

    def add_local_files
      local_files = files.reject { |e| e[:url].match(URI::ABS_URI) }.map { |e| e[:url] }
      self.parsed_metadata['file'] = local_files if local_files.any?
    end

    def add_remote_files
      remote_files = files.select { |e| e[:url].match(URI::ABS_URI) }
      self.parsed_metadata['remote_files'] = remote_files if remote_files.any?
    end

    def add_logical_structure
      self.parsed_metadata['structure'] = record.structure
    end
  end
end

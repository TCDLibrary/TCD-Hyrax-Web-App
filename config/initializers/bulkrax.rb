# frozen_string_literal: true

Bulkrax.setup do |config|
  # Add local parsers
  # config.parsers += [
  #   { name: 'MODS - My Local MODS parser', class_name: 'Bulkrax::ModsXmlParser', partial: 'mods_fields' },
  # ]

  config.parsers = [
    { class_name: 'Bulkrax::FoxmlParser', name: 'FOXML importer', partial: 'foxml_fields' }
  ]

  # Field to use during import to identify if the Work or Collection already exists.
  # Default is 'source'.
  config.system_identifier_field = 'dris_unique'

  # WorkType to use as the default if none is specified in the import
  # Default is the first returned by Hyrax.config.curation_concerns
  # config.default_work_type = MyWork

  # Path to store pending imports
  # config.import_path = 'tmp/imports'

  # Path to store exports before download
  # config.export_path = 'tmp/exports'

  # Server name for oai request header
  # config.server_name = 'my_server@name.com'

  # Field_mapping for establishing the source_identifier
  # This value IS NOT used for OAI, so setting the OAI Entries here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # Example:
  #   {
  #     'Bulkrax::RdfEntry'  => 'http://opaquenamespace.org/ns/contents',
  #     'Bulkrax::CsvEntry'  => 'MyIdentifierField'
  #   }
  # The default value for CSV is 'source_idnetifier'
  # config.source_identifier_field_mapping = { }
  config.source_identifier_field_mapping = {
    'Bulkrax::FoxmlEntry' => 'DrisUnique'
  }

  # Field_mapping for establishing a parent-child relationship (FROM parent TO child)
  # This can be a Collection to Work, or Work to Work relationship
  # This value IS NOT used for OAI, so setting the OAI Entries here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # Example:
  #   {
  #     'Bulkrax::RdfEntry'  => 'http://opaquenamespace.org/ns/contents',
  #     'Bulkrax::CsvEntry'  => 'children'
  #   }
  # By default no parent-child relationships are added
  # config.parent_child_field_mapping = { }

  # Field_mapping for establishing a collection relationship (FROM work TO collection)
  # This value IS NOT used for OAI, so setting the OAI parser here will have no effect
  # The mapping is supplied per Entry, provide the full class name as a string, eg. 'Bulkrax::CsvEntry'
  # The default value for CSV is collection
  # Add/replace parsers, for example:
  # config.collection_field_mapping['Bulkrax::RdfEntry'] = 'http://opaquenamespace.org/ns/set'

  # Field mappings
  # Create a completely new set of mappings by replacing the whole set as follows
  #   config.field_mappings = {
  #     "Bulkrax::OaiDcParser" => { **individual field mappings go here*** }
  #   }

  # Add to, or change existing mappings as follows
  #   e.g. to exclude date
  #   config.field_mappings["Bulkrax::OaiDcParser"]["date"] = { from: ["date"], excluded: true  }

  # To duplicate a set of mappings from one parser to another
  #   config.field_mappings["Bulkrax::OaiOmekaParser"] = {}
  #   config.field_mappings["Bulkrax::OaiDcParser"].each {|key,value| config.field_mappings["Bulkrax::OaiOmekaParser"][key] = value }

  config.field_mappings['Bulkrax::FoxmlParser'] = {

    # @todo understand owner_rec

    # DATA sub-properties - multiple in source
    'creator_loc' => { from: ['AttributedArtist'], parsed: true },
    'creator_local' => { from: ['OtherArtist'], parsed: true },
    'language' => { from: ['Language'], parsed: true },
    'location' => { from: ['Location'], parsed: true },
    'copyright_status' => { from: ['CopyrightHolder'], parsed: true },
    'copyright_note' => { from: ['CopyrightNotes'], parsed: true },
    'location_type' => { from: ['LocationType'], parsed: true },
    'support' => { from: ['Medium'], parsed: true }, # @todo check with joe
    'medium' => { from: ['Support'], parsed: true }, # @todo check with joe
    'subject_lcsh' => { from: ['SubjectLCSH'], parsed: true },
    'keyword' => { from: ['OpenKeyword'], parsed: true },
    'subject_local_keyword' => { from: ['OpenKeyword'], parsed: true },
    'subject_subj_name' => { from: ['LCSubjectNames'], parsed: true },
    'alternative_title' => { from: ['OtherTitle'], parsed: true },
    'series_title' => { from: ['SeriesReportNo'], parsed: true },
    'culture' => { from: ['Culture'], parsed: true },
    # Custom parsing
    'creator' => { from: ['AttributedArtistCalculation', 'OtherArtistCalculation'], parsed: true },
    'contributor' => { from: ['AttributedArtistCalculation', 'OtherArtistCalculation'], parsed: true },
    'provenance' => { from: ['AttributedArtistCalculation', 'OtherArtistCalculation', 'Provenance'], parsed: true },
    'subject' => { from: ['AttributedArtistCalculation', 'OtherArtistCalculation', 'SubjectLCSH', 'LCSubjectNames'], parsed: true },
    'genre' => { from: ['SubjectTMG', 'TypeOfWork'], parsed: true },
    'genre_tgm' => { from: ['SubjectTMG'], parsed: true },
    'genre_aat' => { from: ['TypeOfWork'], parsed: true },
    'description' => { from: ['Abstract'], parsed: true },
    'date_created' => { from: ['DateCalculation'], parsed: true },
    # Singular in source
    'title' => { from: ['Title'] },
    'folder_number' => { from: ['ProjectName'] },
    'abstract' => { from: ['Abstract'] },
    'resource_type' => { from: ['Type'] },
    'bibliography' => { from: ['Bibliography'] },
    'dris_page_no' => { from: ['DrisPageNo'] },
    'dris_document_no' => { from: ['DrisDocumentNo'] },
    'dris_unique' => { from: ['DrisUnique'] },
    'format_duration' => { from: ['FormatDur'] },
    'digital_root_number' => { from: ['CatNo'] },
    'digital_object_identifier' => { from: ['DRISPhotoID'] },
    'identifier' => { from: ['Citation'] },
    'sponsor' => { from: ['Sponsor'] },
    'conservation_history' => { from: ['Introduction'] },
    'publisher' => { from: ['Publisher'] },
    'publisher_location' => { from: ['PublisherCity', 'PublisherCountry'] },
    'page_number' => { from: ['PageNo','PageNoB'] },
    'page_type' => { from: ['PageType', 'PageTypeB'] },
    'physical_extent' => { from: ['FormatW'] },
    'collection_title' => { from: ['TitleLargerEntity'] },
    'county' => { from: ['CALM'] }, # @todo check with Joe
    'project_number' => { from: ['ProjectNo'] },
    'order_no' => { from: ['LCN'] },
    'total_records' => { from: ['PageTotal'] }
  }

  # Properties that should not be used in imports/exports. They are reserved for use by Hyrax.
  # config.reserved_properties += ['my_field']
end

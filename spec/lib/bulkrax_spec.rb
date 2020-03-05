# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bulkrax do
  describe '#config' do
    it 'has custom parsers' do
      expect(described_class.parsers).to eq([
                                              { class_name: 'Bulkrax::FoxmlParser', name: 'FOXML importer', partial: 'foxml_fields' },
                                              { class_name: 'Bulkrax::CsvParser', name: 'CSV importer', partial: 'csv_fields' }
                                            ])
    end

    it 'has custom system_identifier_field' do
      expect(described_class.system_identifier_field).to eq('source')
    end

    it 'has custom source_identifier_field_mapping' do
      expect(described_class.source_identifier_field_mapping).to eq('Bulkrax::FoxmlEntry' => 'DrisUnique')
    end

    it 'has custom field_mappings for the FoxmlParser' do
      expect(described_class.field_mappings['Bulkrax::FoxmlParser']).to eq(
        'creator_loc' => { from: ['AttributedArtist'], parsed: true },
        'creator_local' => { from: ['OtherArtist'], parsed: true },
        'language' => { from: ['Language'], parsed: true },
        'location' => { from: ['Location'], parsed: true },
        'copyright_status' => { from: ['CopyrightHolder'], parsed: true },
        'copyright_note' => { from: ['CopyrightNotes'], parsed: true },
        'location_type' => { from: ['LocationType'], parsed: true },
        'support' => { from: ['Medium'], parsed: true },
        'medium' => { from: ['Support'], parsed: true },
        'subject_lcsh' => { from: ['SubjectLCSH'], parsed: true },
        'keyword' => { from: ['OpenKeyword'], parsed: true },
        'subject_local_keyword' => { from: ['OpenKeyword'], parsed: true },
        'subject_subj_name' => { from: ['LCSubjectNames'], parsed: true },
        'alternative_title' => { from: ['OtherTitle'], parsed: true },
        'series_title' => { from: ['SeriesReportNo'], parsed: true },
        'culture' => { from: ['Culture'], parsed: true },
        'creator' =>
        { from: %w[AttributedArtistCalculation OtherArtistCalculation],
          parsed: true },
        'contributor' =>
        { from: %w[AttributedArtistCalculation OtherArtistCalculation],
          parsed: true },
        'provenance' =>
        { from: %w[AttributedArtistCalculation OtherArtistCalculation Provenance],
          parsed: true },
        'subject' =>
        { from: %w[AttributedArtistCalculation
                   OtherArtistCalculation
                   SubjectLCSH
                   LCSubjectNames],
          parsed: true },
        'genre' => { from: %w[SubjectTMG TypeOfWork], parsed: true },
        'genre_tgm' => { from: ['SubjectTMG'], parsed: true },
        'genre_aat' => { from: ['TypeOfWork'], parsed: true },
        'description' => { from: ['Abstract'], parsed: true },
        'date_created' => { from: ['DateCalculation'], parsed: true },
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
        'publisher_location' => { from: %w[PublisherCity PublisherCountry] },
        'page_number' => { from: %w[PageNo PageNoB] },
        'page_type' => { from: %w[PageType PageTypeB] },
        'physical_extent' => { from: ['FormatW'] },
        'collection_title' => { from: ['TitleLargerEntity'] },
        'county' => { from: ['CALM'] },
        'project_number' => { from: ['ProjectNo'] },
        'order_no' => { from: ['LCN'] },
        'total_records' => { from: ['PageTotal'] }
      )
    end
  end
end

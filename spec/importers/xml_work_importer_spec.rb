# frozen_string_literal: true
require 'rails_helper'
require 'active_fedora/cleaner'


RSpec.describe XmlWorkImporter do

  let(:file_example)       { 'spec/fixtures/Named_Collection_Example_OBJECT RECORDS_v3.6_20181207.xml' }

  before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    ActiveFedora::Cleaner.clean!
  end

  it "stores data in correct fields in the work" do
     expect { XmlWorkImporter.new(file_example).import }.to change { Work.count }.by 1

     imported_work = Work.first
     expect(imported_work.title.first).to eq('Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton')
     expect(imported_work.depositor).to eq('cataloger@tcd.ie')
     expect(imported_work.creator).to include('D’Alton, John, 1792-1867')
     expect(imported_work.keyword).to include('Correspondence')
     expect(imported_work.rights_statement.first).to eq('Expired')

     expect(imported_work.description).to include('TCD MS 2327/64 is a letter from Catherine (Kate) D’Alton (née Phillips, of Clonmore, Co. Mayo, 1815-1853) to her...')
     expect(imported_work.publisher).to include('A Publisher Name')
     expect(imported_work.date_created).to include('DateType: start; Day: 08-08-1824 A.D.')
     expect(imported_work.subject).to include ('Correspondence')
     expect(imported_work.language).to include ('English')
     expect(imported_work.identifier).to include ('MS2327-64')
     # TODO: expect(imported_work.location).to include ('Manuscripts &amp; Archives Research Library, Trinity College Dublin')
     # TODO: expect(imported_work.related_url).to include
     # TODO: expect(imported_work.source).to include ('')
     expect(imported_work.resource_type).to include ('text')
     expect(imported_work.genre).to include ('objects')
     expect(imported_work.bibliography).to include ('A Bibliography Value')
     expect(imported_work.dris_page_no).to include ('folio _ ')
     expect(imported_work.dris_document_no).to include ('MS2327-64_folio _ ')
     expect(imported_work.dris_unique).to include ('0145514')
     expect(imported_work.format_duration).to include ('A format dur')
     expect(imported_work.format_resolution).to include ('A format res')
     expect(imported_work.copyright_holder).to include ('Public domain')
     expect(imported_work.copyright_note).to include ('Some copyright notes')
     expect(imported_work.digital_root_number).to include('MS2327-64')
     expect(imported_work.digital_object_identifier).to include('MS2327-64_0')
     expect(imported_work.language_code).to include('eng')
     expect(imported_work.location_type).to include('repository')
     expect(imported_work.shelf_locator).to include('IE TCD MS 2327/64')
     expect(imported_work.role_code).to include('rcp')
     expect(imported_work.role).to include('Donor')
     expect(imported_work.sponsor).to include('Sponsor name')
     expect(imported_work.conservation_history).to include('Conservation history')
     expect(imported_work.publisher_location).to include('The publishers city')
     expect(imported_work.publisher_location).to include('The publishers country')
     expect(imported_work.page_number).to include('n/a')
     expect(imported_work.page_number).to include('n/a B')
     expect(imported_work.page_type).to include('folio')
     expect(imported_work.page_type).to include('other page type')
     expect(imported_work.physical_extent).to include('Physical extent')
     expect(imported_work.support).to include('ink')
     expect(imported_work.medium).to include('paper (fiber product)')
     expect(imported_work.type_of_work).to include('objects')
     expect(imported_work.related_item_type).to include('host')
     expect(imported_work.related_item_identifier).to include('0145515')
     expect(imported_work.related_item_title).to include('Correspondence of John and Catherine D\'Alton')
     expect(imported_work.subject_lcsh).to include('Subject lcsh')
     expect(imported_work.subject_local).to include('D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence')
     expect(imported_work.subject_name).to include('D’Alton, John, 1792-1867--Correspondence')
     expect(imported_work.alternative_title).to include('An other title')
     expect(imported_work.series_title).to include('A series report no')
     expect(imported_work.collection_title).to include('Correspondence of John and Catherine D\'Alton')
     expect(imported_work.virtual_collection_title).to include('Second title larger entity')
     expect(imported_work.provenance).to include('Donated to the Library of Trinity College, Dublin by Father Wallace Clare, St. Joseph’s College, Ipswich, Suffolk, 8 December 1951.')
     expect(imported_work.visibility_flag).to include('COLLECTION/OBJECT')
     expect(imported_work.europeana).to include('No')
     expect(imported_work.solr_flag).to include('No')
     expect(imported_work.culture).to include('Irish')
     expect(imported_work.county).to include('Calm ref')
     expect(imported_work.project_number).to include('Project 1822')
     expect(imported_work.order_no).to include('LCN no')
     expect(imported_work.total_records).to include('1')


  end

end
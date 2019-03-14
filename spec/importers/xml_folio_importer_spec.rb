# frozen_string_literal: true
require 'rails_helper'
require 'active_fedora/cleaner'


RSpec.describe XmlFolioImporter do

  #let(:file_example)       { 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml' }
  let(:file_example)       { 'Named Collection Example_PARTS_ONE_OBJECT.XML' }
  let(:base_folder)        { 'spec/fixtures/' }
  let(:sub_folder)         { '' }
  let(:parent_id)          { '000000000' }
  let(:parent_type)        { 'no_parent' }


  before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    ActiveFedora::Cleaner.clean!
  end

  it "stores data in correct fields in the Folio" do
     #XmlFolioImporter.new(file_example).import
     expect { XmlFolioImporter.new(::User.batch_user, file_example, parent_id, parent_type,  'LO', base_folder).import }.to change { Folio.count }.by 1

     imported_folio = Folio.first
     expect(imported_folio.title.first).to eq('Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton')
     expect(imported_folio.depositor).to eq(::User.batch_user.email)
     expect(imported_folio.creator).to include('D’Alton, John, 1792-1867, Addressee')
     expect(imported_folio.keyword).to include('D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence')
     expect(imported_folio.rights_statement.first).to include('http://rightsstatements.org/vocab/NKC/1.0/')
     expect(imported_folio.description).to include('TCD MS 2327/64 is a letter from Catherine (Kate) D’Alton (née Phillips, of Clonmore, Co. Mayo, 1815-1853) to her husband, John William Alexander D’Alton (of Bessville, Co. Meath, 1792-1867).  Written d...')
     #expect(imported_folio.abstract).to include('TCD MS 2327/64 is a letter from Catherine (Kate) D’Alton (née Phillips, of Clonmore, Co. Mayo, 1815-1853) to her...')
     expect(imported_folio.publisher).to include('A Publisher Name')
     expect(imported_folio.date_created).to include('start; 08-08-1824 end; 12-08-1824 ')
     expect(imported_folio.subject).to include ('D’Alton, John, 1792-1867--Correspondence')
     expect(imported_folio.language).to include ('English')
     expect(imported_folio.identifier).to include ('IE TCD MS 2327/64')
     # TODO: expect(imported_folio.location).to include ('Manuscripts &amp; Archives Research Library, Trinity College Dublin')
     # TODO: expect(imported_folio.related_url).to include
     # TODO: expect(imported_folio.source).to include ('')
     expect(imported_folio.resource_type).to include ('text')
     expect(imported_folio.genre).to include ('letters (correspondence)')
     expect(imported_folio.genre).to include ('Correspondence')
     expect(imported_folio.bibliography).to include ('A Bibliography Value')
     expect(imported_folio.dris_page_no).to include ('folio [1]r_ ')
     expect(imported_folio.dris_document_no).to include ('MS2327-64_folio [1]r_ ')
     expect(imported_folio.dris_unique).to include ('0145516')
     expect(imported_folio.format_duration).to include ('A format dur')
     expect(imported_folio.format_resolution).to include ('A format res')
     expect(imported_folio.copyright_status).to include ('Public domain')
     expect(imported_folio.copyright_note).to include ('Some copyright notes')
     expect(imported_folio.digital_root_number).to include('MS2327-64')
     expect(imported_folio.digital_object_identifier).to include('MS2327-64_1')
     #expect(imported_folio.language_code).to include('eng')
     expect(imported_folio.location_type).to include('repository')
     #expect(imported_folio.shelf_locator).to include('IE TCD MS 2327/64')
     #expect(imported_folio.role_code).to include('rcp')
     #expect(imported_folio.role).to include('Donor')
     expect(imported_folio.sponsor).to include('Sponsor name')
     expect(imported_folio.conservation_history).to include('Conservation history')
     expect(imported_folio.publisher_location).to include('The publishers city')
     expect(imported_folio.publisher_location).to include('The publishers country')
     expect(imported_folio.page_number).to include('[1]r')
     expect(imported_folio.page_number).to include('other page no')
     expect(imported_folio.page_type).to include('folio')
     expect(imported_folio.page_type).to include('other page type')
     expect(imported_folio.physical_extent).to include('Physical extent')
     expect(imported_folio.medium).to include('ink')
     expect(imported_folio.support).to include('paper (fiber product)')
     #expect(imported_folio.type_of_work).to include('letters (correspondence)')
     expect(imported_folio.related_item_type).to include('host')
     expect(imported_folio.related_item_identifier).to include('0145514')
     expect(imported_folio.related_item_title).to include('Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton')
     #expect(imported_folio.subject_lcsh).to include('Subject lcsh')
     #expect(imported_folio.subject_local).to include('D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence')
     #expect(imported_folio.subject_name).to include('D’Alton, John, 1792-1867--Correspondence')
     expect(imported_folio.alternative_title).to include('An other title')
     expect(imported_folio.series_title).to include('A series report no')
     expect(imported_folio.collection_title).to include('Correspondence of John and Catherine D\'Alton')
     expect(imported_folio.virtual_collection_title).to include('Second title larger entity')
     expect(imported_folio.provenance).to include('Donated to the Library of Trinity College, Dublin by Father Wallace Clare, St. Joseph’s College, Ipswich, Suffolk, 8 December 1951.')
     expect(imported_folio.visibility_flag).to include('ONLINE')
     expect(imported_folio.europeana).to include('No')
     expect(imported_folio.solr_flag).to include('Cover')
     expect(imported_folio.culture).to include('Irish')
     expect(imported_folio.county).to include('Calm ref')
     expect(imported_folio.project_number).to include('Project 1822')
     expect(imported_folio.order_no).to include('LCN no')
     expect(imported_folio.total_records).to include('4')

  end

end

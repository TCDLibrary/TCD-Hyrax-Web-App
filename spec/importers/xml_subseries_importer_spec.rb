# frozen_string_literal: true
require 'rails_helper'
require 'active_fedora/cleaner'


RSpec.describe FoxmlImporter do

  let(:file_example)       { 'Named Collection Example_SUBSERIES_ONE_OBJECT.XML' }
  let(:base_folder)        { 'spec/fixtures/' }
  let(:sub_folder)         { '' }
  let(:parent_id)          { '000000000' }
  let(:parent_type)        { 'no_parent' }
  let(:object_model)       { 'Single Object, Multiple Images' }
  let(:visibility)         { 'Public'}

  before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    ActiveFedora::Cleaner.clean!
  end

  it "stores data in correct fields in the Subseries" do
     artefact = Subseries
     expect { FoxmlImporter.new(object_model, ::User.batch_user, file_example, parent_id, parent_type,  'LO', visibility, base_folder).import(artefact) }.to change { Subseries.count }.by 1

     imported_subseries = Subseries.first
     expect(imported_subseries.title.first).to eq('Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton')
     expect(imported_subseries.depositor).to eq(::User.batch_user.email)
     expect(imported_subseries.creator).to include('D’Alton, Catherine (Kate), approximately 1795-1859, Author')
     expect(imported_subseries.keyword).to include('D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence')
     expect(imported_subseries.rights_statement).to include('Copyright The Board of Trinity College Dublin. Images are available for single-use academic application only. Publication, transmission or display is prohibited without formal written approval of the Library of Trinity College, Dublin.')
     expect(imported_subseries.description).to include('TCD MS 2327/64 is a letter from Catherine (Kate) D’Alton (née Phillips, of Clonmore, Co. Mayo, 1815-1853) to her husband, John William Alexander D’Alton (of Bessville, Co. Meath, 1792-1867).  Written d...')

     expect(imported_subseries.publisher).to include('A Publisher Name')
     expect(imported_subseries.date_created).to include('start; 08-08-1824 end; 12-08-1824 ')
     expect(imported_subseries.subject).to include ('D’Alton, John, 1792-1867--Correspondence')
     expect(imported_subseries.language).to include ('English')
     expect(imported_subseries.identifier).to include ('IE TCD MS 2327/64')

     expect(imported_subseries.resource_type).to include ('text')
     expect(imported_subseries.genre).to include ('letters (correspondence)')
     expect(imported_subseries.genre).to include ('Correspondence')
     expect(imported_subseries.bibliography).to include ('A Bibliography Value')
     expect(imported_subseries.dris_page_no).to include ('folio [1]r_ ')
     expect(imported_subseries.dris_document_no).to include ('MS2327-64_folio [1]r_ ')
     expect(imported_subseries.dris_unique).to include ('0145516')
     expect(imported_subseries.format_duration).to include ('A format dur')

     expect(imported_subseries.copyright_status).to include ('Public domain')
     expect(imported_subseries.copyright_note).to include ('Some copyright notes')
     expect(imported_subseries.digital_root_number).to include('MS2327-64')
     expect(imported_subseries.digital_object_identifier).to include('MS2327-64_1')

     expect(imported_subseries.location_type).to include('repository')

     expect(imported_subseries.sponsor).to include('Sponsor name')
     expect(imported_subseries.conservation_history).to include('Conservation history')
     expect(imported_subseries.publisher_location).to include('The publishers city')
     expect(imported_subseries.publisher_location).to include('The publishers country')
     expect(imported_subseries.page_number).to include('[1]r')
     expect(imported_subseries.page_number).to include('other page no')
     expect(imported_subseries.page_type).to include('folio')
     expect(imported_subseries.page_type).to include('other page type')
     expect(imported_subseries.physical_extent).to include('Physical extent')
     expect(imported_subseries.medium).to include('ink')
     expect(imported_subseries.support).to include('paper (fiber product)')

     expect(imported_subseries.alternative_title).to include('An other title')
     expect(imported_subseries.series_title).to include('A series report no')
     expect(imported_subseries.collection_title).to include('Correspondence of John and Catherine D\'Alton')

     expect(imported_subseries.provenance).to include('Donated to the Library of Trinity College, Dublin by Father Wallace Clare, St. Joseph’s College, Ipswich, Suffolk, 8 December 1951.')
     expect(imported_subseries.culture).to include('Irish')
     expect(imported_subseries.county).to include('Calm ref')
     expect(imported_subseries.project_number).to include('Project 1822')
     expect(imported_subseries.order_no).to include('LCN no')
     expect(imported_subseries.total_records).to include('4')

     # 29/03/2019 JL - split creator, genre and subject for Michelle
     expect(imported_subseries.creator_loc).to include ('Clare, Wallace, 1895-1963') #AttributedArtist
     expect(imported_subseries.creator_local).to include ("D’Alton, Catherine (Kate), approximately 1795-1859") #OtherArtist
     expect(imported_subseries.genre_aat).to include ("letters (correspondence)") #TypeOfWork
     expect(imported_subseries.genre_tgm).to include ("Manuscripts") #SubjectTMG
     expect(imported_subseries.subject_lcsh).to be_empty #SubjectLCSH
     expect(imported_subseries.subject_subj_name).to include ("D’Alton, John, 1792-1867--Correspondence") #LCSubjectNames
     expect(imported_subseries.subject_local_keyword).to include ("D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence") #OpenKeyword
     expect(imported_subseries.visibility).to include ("open")

  end

end

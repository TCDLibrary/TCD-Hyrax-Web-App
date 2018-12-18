# frozen_string_literal: true
require 'rails_helper'
require 'active_fedora/cleaner'


RSpec.describe XmlFolioImporter do

  let(:file_example)       { 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml' }

  before do
    DatabaseCleaner.clean
    ActiveFedora::Cleaner.clean!
  end

  it "imports an xml folio" do
      expect { XmlFolioImporter.new(file_example).import }.to change { Folio.count }.by 1
  end

  it "stores data in correct fields in the Folio" do
     XmlFolioImporter.new(file_example).import
     imported_folio = Folio.first
     expect(imported_folio.title.first).to eq('Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton')
     expect(imported_folio.depositor).to eq(::User.batch_user.email)
     expect(imported_folio.creator).to include('D’Alton, John, 1792-1867')
     expect(imported_folio.keyword).to include('Correspondence')
     expect(imported_folio.rights_statement.first).to eq('Expired')
  end

end

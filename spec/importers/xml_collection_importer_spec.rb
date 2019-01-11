# frozen_string_literal: true
require 'rails_helper'
require 'active_fedora/cleaner'


RSpec.describe XmlCollectionImporter do

  let(:file_example)       { 'spec/fixtures/Named Collection Example_NAMED COLLECTION RECORD v3.6_20181207.xml' }

  before do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    ActiveFedora::Cleaner.clean!
  end

  it "imports an xml collection" do
      expect { XmlCollectionImporter.new(file_example).import }.to change { Collection.count }.by 1
  end

  it "stores data in correct fields in the collection" do
     XmlCollectionImporter.new(file_example).import
     imported_collection = Collection.first
     # byebug
     expect(imported_collection.title.first).to eq('Correspondence of John and Catherine D\'Alton')
     expect(imported_collection.depositor).to eq('test@example.com')
     expect(imported_collection.creator).to include('D’Alton, John, 1792-1867')
     expect(imported_collection.keyword).to include('Correspondence')
  end

end

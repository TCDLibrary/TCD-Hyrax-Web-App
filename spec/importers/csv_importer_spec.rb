# frozen_string_literal: true
require 'rails_helper'
require 'active_fedora/cleaner'


RSpec.describe CsvImporter do

  let(:file_example)       { 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml' }

  before do
    DatabaseCleaner.clean
    ActiveFedora::Cleaner.clean!
  end

  #it "instantiates the class CsvImporter" do
  #  CsvImporter.new()
  #end

  it "imports a csv" do
      expect { CsvImporter.new(file_example).import }.to change { Work.count }.by 1
  end

  it "stores data in correct fields in the work" do
     CsvImporter.new(file_example).import
     imported_work = Work.first
     expect(imported_work.title.first).to eq('Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton')
     expect(imported_work.depositor).to eq('cataloger@tcd.ie')
     expect(imported_work.creator.first).to eq('D’Alton, John, 1792-1867')
     expect(imported_work.keyword.first).to eq('Correspondence')
     expect(imported_work.rights_statement.first).to eq('Expired')
  end

end

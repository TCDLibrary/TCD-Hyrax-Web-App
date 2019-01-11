class ImportController < ApplicationController
  def index
    file_example = 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml'
    XmlFolioImporter.new(file_example).import
  end
end

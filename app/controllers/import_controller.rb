class ImportController < ApplicationController
  def index
    file_example = 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml'
    parent = '000000000'
    XmlFolioImporter.new(file_example, parent).import
  end
end

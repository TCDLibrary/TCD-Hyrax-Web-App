# Generated via
#  `rails generate hyrax:work Folio`
require 'rails_helper'

RSpec.describe Folio do
  # 13-12-2018 JL:
  describe "#additional metadata for Trinity College Dublin" do
    context "with a new Folio" do
      it "has no TCD metadata values when it is first created" do
        folio = Folio.new
        expect(folio.abstract).to be_empty
        expect(folio.genre).to be_empty
        expect(folio.bibliography).to be_empty
        expect(folio.dris_page_no).to be_empty
        expect(folio.dris_document_no).to be_empty
        expect(folio.dris_unique).to be_empty
        expect(folio.format_duration).to be_empty
        expect(folio.format_resolution).to be_empty
        expect(folio.copyright_status).to be_empty
        expect(folio.copyright_note).to be_empty
        expect(folio.digital_root_number).to be_empty
        expect(folio.digital_object_identifier).to be_empty
        expect(folio.language_code).to be_empty
        expect(folio.location_type).to be_empty
        expect(folio.shelf_locator).to be_empty
        #expect(folio.role).to be_empty
        #expect(folio.role_code).to be_empty
        expect(folio.sponsor).to be_empty
        expect(folio.conservation_history).to be_empty
        expect(folio.publisher_location).to be_empty
        expect(folio.page_number).to be_empty
        expect(folio.page_type).to be_empty
        expect(folio.physical_extent).to be_empty
        expect(folio.support).to be_empty
        expect(folio.medium).to be_empty
        #expect(folio.type_of_work).to be_empty
        expect(folio.related_item_type).to be_empty
        expect(folio.related_item_identifier).to be_empty
        expect(folio.related_item_title).to be_empty
        #expect(folio.subject_lcsh).to be_empty
        #expect(folio.subject_local).to be_empty
        #expect(folio.subject_name).to be_empty
        expect(folio.alternative_title).to be_empty
        expect(folio.series_title).to be_empty
        expect(folio.collection_title).to be_empty
        expect(folio.virtual_collection_title).to be_empty
        expect(folio.provenance).to be_empty
        expect(folio.visibility_flag).to be_empty
        expect(folio.europeana).to be_empty
        expect(folio.solr_flag).to be_empty
        expect(folio.culture).to be_empty
        expect(folio.county).to be_empty
        expect(folio.folder_number).to be_empty
        expect(folio.project_number).to be_empty
        expect(folio.order_no).to be_empty
        expect(folio.total_records).to be_empty
        expect(folio.location).to be_empty

      end
    end
    context "with a Folio that has TCD metadata defined" do
      it "can set and retrieve a extended metadata values" do
        folio = Folio.new
        folio.abstract = ["An Abstract"]
        folio.genre = ["A Folio Genre"]
        folio.bibliography = ["A Folio Bibliography"]
        folio.dris_page_no = ["A Folio Dris Page No"]
        folio.dris_document_no = ["A Folio Dris Document No"]
        folio.dris_unique = ["A Dris Unique"]
        folio.format_duration = ["A Format Duration"]
        folio.format_resolution = ["A Format Resolution"]
        folio.copyright_status = ["A Copyright Holder"]
        folio.copyright_note = ["A Copyright Note"]
        folio.digital_root_number = ["A Digital Root Number"]
        folio.digital_object_identifier = ["A Digital Object Identifier"]
        folio.language_code = ["A Language Code"]
        folio.location_type = ["A Location Type"]
        folio.shelf_locator = ["A Shelf Locator"]
        #folio.role = ["A Role"]
        #folio.role_code = ["A Role Code"]
        folio.sponsor = ["A Sponsor"]
        folio.conservation_history = ["A Conservation History"]
        folio.publisher_location = ["A Publisher Location"]
        folio.page_number = ["A Page Number"]
        folio.page_type = ["A Page Type"]
        folio.physical_extent = ["A Physical Extent"]
        folio.support = ["A Support"]
        folio.medium = ["A Medium"]
        #folio.type_of_work = ["A Type Of Work"]
        folio.related_item_type = ["A Related Item Type"]
        folio.related_item_identifier = ["A Related Item Identifier"]
        folio.related_item_title = ["A Related Item Title"]
        #folio.subject_lcsh = ["A Subject LCSH"]
        #folio.subject_local = ["A Subject Local"]
        #folio.subject_name = ["A Subject Name"]
        folio.alternative_title = ["An Alternative Title"]
        folio.series_title = ["A Series Title"]
        folio.collection_title = ["A Collection Title"]
        folio.virtual_collection_title = ["A Virtual Collection Title"]
        folio.provenance = ["A Provenance"]
        folio.visibility_flag = ["A Visibility Flag"]
        folio.europeana = ["A Europeana"]
        folio.solr_flag = ["A Solr Flag"]
        folio.culture = ["A Culture"]
        folio.county = ["A County"]
        folio.folder_number = ["A Folder Number"]
        folio.project_number = ["A Project Number"]
        folio.order_no = ["An Order No"]
        folio.total_records = ["A Total Records"]
        folio.location = ["A Location"]

        expect(folio.abstract).to eq(["An Abstract"])
        expect(folio.genre).to eq(["A Folio Genre"])
        expect(folio.bibliography).to eq(["A Folio Bibliography"])
        expect(folio.dris_page_no).to eq(["A Folio Dris Page No"])
        expect(folio.dris_document_no).to eq(["A Folio Dris Document No"])
        expect(folio.dris_unique).to eq(["A Dris Unique"])
        expect(folio.format_duration).to eq (["A Format Duration"])
        expect(folio.format_resolution).to eq (["A Format Resolution"])
        expect(folio.copyright_status).to eq (["A Copyright Holder"])
        expect(folio.copyright_note).to eq (["A Copyright Note"])
        expect(folio.digital_root_number).to eq (["A Digital Root Number"])
        expect(folio.digital_object_identifier).to eq (["A Digital Object Identifier"])
        expect(folio.language_code).to eq (["A Language Code"])
        expect(folio.location_type).to eq (["A Location Type"])
        expect(folio.shelf_locator).to eq (["A Shelf Locator"])
        #expect(folio.role).to eq (["A Role"])
        #expect(folio.role_code).to eq (["A Role Code"])
        expect(folio.sponsor).to eq (["A Sponsor"])
        expect(folio.conservation_history).to eq (["A Conservation History"])
        expect(folio.publisher_location).to eq (["A Publisher Location"])
        expect(folio.page_number).to eq (["A Page Number"])
        expect(folio.page_type).to eq (["A Page Type"])
        expect(folio.physical_extent).to eq (["A Physical Extent"])
        expect(folio.support).to eq (["A Support"])
        expect(folio.medium).to eq (["A Medium"])
        #expect(folio.type_of_work).to eq (["A Type Of Work"])
        expect(folio.related_item_type).to eq (["A Related Item Type"])
        expect(folio.related_item_identifier).to eq (["A Related Item Identifier"])
        expect(folio.related_item_title).to eq (["A Related Item Title"])
        #expect(folio.subject_lcsh).to eq (["A Subject LCSH"])
        #expect(folio.subject_local).to eq (["A Subject Local"])
        #expect(folio.subject_name).to eq (["A Subject Name"])
        expect(folio.alternative_title).to eq  (["An Alternative Title"])
        expect(folio.series_title).to eq  (["A Series Title"])
        expect(folio.collection_title).to eq (["A Collection Title"])
        expect(folio.virtual_collection_title).to eq (["A Virtual Collection Title"])
        expect(folio.provenance).to eq (["A Provenance"])
        expect(folio.visibility_flag).to eq (["A Visibility Flag"])
        expect(folio.europeana).to eq (["A Europeana"])
        expect(folio.solr_flag).to eq (["A Solr Flag"])
        expect(folio.culture).to eq (["A Culture"])
        expect(folio.county).to eq (["A County"])
        expect(folio.folder_number).to eq (["A Folder Number"])
        expect(folio.project_number).to eq (["A Project Number"])
        expect(folio.order_no).to eq (["An Order No"])
        expect(folio.total_records).to eq (["A Total Records"])
        expect(folio.location).to eq (["A Location"])

      end
    end
  end

end

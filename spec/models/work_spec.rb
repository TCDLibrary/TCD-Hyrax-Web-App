# Generated via
#  `rails generate hyrax:work Work`
require 'rails_helper'

RSpec.describe Work do
  # 20-11-2018 JL:
  describe "#additional metadata for Trinity College Dublin" do
    context "with a new Work" do
      it "has no TCD metadata values when it is first created" do
        work = Work.new
        expect(work.abstract).to be_empty
        expect(work.genre).to be_empty
        expect(work.bibliography).to be_empty
        expect(work.dris_page_no).to be_empty
        expect(work.dris_document_no).to be_empty
        expect(work.dris_unique).to be_empty
        expect(work.format_duration).to be_empty
        expect(work.format_resolution).to be_empty
        expect(work.copyright_status).to be_empty
        expect(work.copyright_note).to be_empty
        expect(work.digital_root_number).to be_empty
        expect(work.digital_object_identifier).to be_empty
        #expect(work.language_code).to be_empty
        expect(work.location_type).to be_empty
        expect(work.shelf_locator).to be_empty
        #expect(work.role).to be_empty
        #expect(work.role_code).to be_empty
        expect(work.sponsor).to be_empty
        expect(work.conservation_history).to be_empty
        expect(work.publisher_location).to be_empty
        expect(work.page_number).to be_empty
        expect(work.page_type).to be_empty
        expect(work.physical_extent).to be_empty
        expect(work.support).to be_empty
        expect(work.medium).to be_empty
        #expect(work.type_of_work).to be_empty
        expect(work.related_item_type).to be_empty
        expect(work.related_item_identifier).to be_empty
        expect(work.related_item_title).to be_empty
        #expect(work.subject_lcsh).to be_empty
        #expect(work.subject_local).to be_empty
        #expect(work.subject_name).to be_empty
        expect(work.alternative_title).to be_empty
        expect(work.series_title).to be_empty
        expect(work.collection_title).to be_empty
        expect(work.virtual_collection_title).to be_empty
        expect(work.provenance).to be_empty
        expect(work.visibility_flag).to be_empty
        expect(work.europeana).to be_empty
        expect(work.solr_flag).to be_empty
        expect(work.culture).to be_empty
        expect(work.county).to be_empty
        expect(work.folder_number).to be_empty
        expect(work.project_number).to be_empty
        expect(work.order_no).to be_empty
        expect(work.total_records).to be_empty
        expect(work.location).to be_empty

      end
    end
    context "with a Work that has TCD metadata defined" do
      it "can set and retrieve a genre value" do
        work = Work.new
        work.abstract = ["An Abstract"]
        work.genre = ["A Work Genre"]
        work.bibliography = ["A Work Bibliography"]
        work.dris_page_no = ["A Work Dris Page No"]
        work.dris_document_no = ["A Work Dris Document No"]
        work.dris_unique = ["A Dris Unique"]
        work.format_duration = ["A Format Duration"]
        work.format_resolution = ["A Format Resolution"]
        work.copyright_status = ["A Copyright Holder"]
        work.copyright_note = ["A Copyright Note"]
        work.digital_root_number = ["A Digital Root Number"]
        work.digital_object_identifier = ["A Digital Object Identifier"]
        #work.language_code = ["A Language Code"]
        work.location_type = ["A Location Type"]
        work.shelf_locator = ["A Shelf Locator"]
        #work.role = ["A Role"]
        #work.role_code = ["A Role Code"]
        work.sponsor = ["A Sponsor"]
        work.conservation_history = ["A Conservation History"]
        work.publisher_location = ["A Publisher Location"]
        work.page_number = ["A Page Number"]
        work.page_type = ["A Page Type"]
        work.physical_extent = ["A Physical Extent"]
        work.support = ["A Support"]
        work.medium = ["A Medium"]
        #work.type_of_work = ["A Type Of Work"]
        work.related_item_type = ["A Related Item Type"]
        work.related_item_identifier = ["A Related Item Identifier"]
        work.related_item_title = ["A Related Item Title"]
        #work.subject_lcsh = ["A Subject LCSH"]
        #work.subject_local = ["A Subject Local"]
        #work.subject_name = ["A Subject Name"]
        work.alternative_title = ["An Alternative Title"]
        work.series_title = ["A Series Title"]
        work.collection_title = ["A Collection Title"]
        work.virtual_collection_title = ["A Virtual Collection Title"]
        work.provenance = ["A Provenance"]
        work.visibility_flag = ["A Visibility Flag"]
        work.europeana = ["A Europeana"]
        work.solr_flag = ["A Solr Flag"]
        work.culture = ["A Culture"]
        work.county = ["A County"]
        work.folder_number = ["A Folder Number"]
        work.project_number = ["A Project Number"]
        work.order_no = ["An Order No"]
        work.total_records = ["A Total Records"]
        work.location = ["A Location"]

        expect(work.abstract).to eq(["An Abstract"])
        expect(work.genre).to eq(["A Work Genre"])
        expect(work.bibliography).to eq(["A Work Bibliography"])
        expect(work.dris_page_no).to eq(["A Work Dris Page No"])
        expect(work.dris_document_no).to eq(["A Work Dris Document No"])
        expect(work.dris_unique).to eq(["A Dris Unique"])
        expect(work.format_duration).to eq (["A Format Duration"])
        expect(work.format_resolution).to eq (["A Format Resolution"])
        expect(work.copyright_status).to eq (["A Copyright Holder"])
        expect(work.copyright_note).to eq (["A Copyright Note"])
        expect(work.digital_root_number).to eq (["A Digital Root Number"])
        expect(work.digital_object_identifier).to eq (["A Digital Object Identifier"])
        #expect(work.language_code).to eq (["A Language Code"])
        expect(work.location_type).to eq (["A Location Type"])
        expect(work.shelf_locator).to eq (["A Shelf Locator"])
        #expect(work.role).to eq (["A Role"])
        #expect(work.role_code).to eq (["A Role Code"])
        expect(work.sponsor).to eq (["A Sponsor"])
        expect(work.conservation_history).to eq (["A Conservation History"])
        expect(work.publisher_location).to eq (["A Publisher Location"])
        expect(work.page_number).to eq (["A Page Number"])
        expect(work.page_type).to eq (["A Page Type"])
        expect(work.physical_extent).to eq (["A Physical Extent"])
        expect(work.support).to eq (["A Support"])
        expect(work.medium).to eq (["A Medium"])
        #expect(work.type_of_work).to eq (["A Type Of Work"])
        expect(work.related_item_type).to eq (["A Related Item Type"])
        expect(work.related_item_identifier).to eq (["A Related Item Identifier"])
        expect(work.related_item_title).to eq (["A Related Item Title"])
        #expect(work.subject_lcsh).to eq (["A Subject LCSH"])
        #expect(work.subject_local).to eq (["A Subject Local"])
        #expect(work.subject_name).to eq (["A Subject Name"])
        expect(work.alternative_title).to eq  (["An Alternative Title"])
        expect(work.series_title).to eq  (["A Series Title"])
        expect(work.collection_title).to eq (["A Collection Title"])
        expect(work.virtual_collection_title).to eq (["A Virtual Collection Title"])
        expect(work.provenance).to eq (["A Provenance"])
        expect(work.visibility_flag).to eq (["A Visibility Flag"])
        expect(work.europeana).to eq (["A Europeana"])
        expect(work.solr_flag).to eq (["A Solr Flag"])
        expect(work.culture).to eq (["A Culture"])
        expect(work.county).to eq (["A County"])
        expect(work.folder_number).to eq (["A Folder Number"])
        expect(work.project_number).to eq (["A Project Number"])
        expect(work.order_no).to eq (["An Order No"])
        expect(work.total_records).to eq (["A Total Records"])
        expect(work.location).to eq (["A Location"])

      end
    end
  end

end

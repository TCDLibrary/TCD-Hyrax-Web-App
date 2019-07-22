require 'rails_helper'

RSpec.describe Collection do

  # 13-12-2018 JL:
  describe "#additional metadata for Trinity College Dublin" do
    context "with a new Collection" do

        it "has no metadata values when it is first created" do
          coll = Collection.new
          expect(coll.creator).to be_empty
          expect(coll.contributor).to be_empty
          expect(coll.keyword).to be_empty
          expect(coll.publisher).to be_empty
          expect(coll.date_created).to be_empty
          expect(coll.subject).to be_empty
          expect(coll.language).to be_empty
          expect(coll.identifier).to be_empty
          expect(coll.related_url).to be_empty
          # extra metadata fields for TCD:
          # expect(coll.genre).to be_empty
          # expect(coll.bibliography).to be_empty
          # expect(coll.dris_page_no).to be_empty
          # expect(coll.dris_document_no).to be_empty
          # expect(coll.dris_unique).to be_empty
          # expect(coll.format_duration).to be_empty

          # expect(coll.copyright_status).to be_empty
          # expect(coll.copyright_note).to be_empty
          # expect(coll.digital_root_number).to be_empty
          # expect(coll.digital_object_identifier).to be_empty
          # expect(coll.language_code).to be_empty
          # expect(coll.location_type).to be_empty
          # expect(coll.shelf_locator).to be_empty
          # expect(coll.role).to be_empty
          # expect(coll.role_code).to be_empty
          # expect(coll.sponsor).to be_empty
          # expect(coll.conservation_history).to be_empty
          # expect(coll.publisher_location).to be_empty
          # expect(coll.page_number).to be_empty
          # expect(coll.page_type).to be_empty
          # expect(coll.physical_extent).to be_empty
          # expect(coll.support).to be_empty
          # expect(coll.medium).to be_empty
          # expect(coll.type_of_work).to be_empty

          # expect(coll.subject_lcsh).to be_empty
          # expect(coll.subject_local).to be_empty
          # expect(coll.subject_name).to be_empty
          # expect(coll.alternative_title).to be_empty
          # expect(coll.series_title).to be_empty
          # expect(coll.collection_title).to be_empty

          # expect(coll.provenance).to be_empty

          # expect(coll.culture).to be_empty
          # expect(coll.county).to be_empty
          # expect(coll.folder_number).to be_empty
          # expect(coll.project_number).to be_empty
          # expect(coll.order_no).to be_empty
          # expect(coll.total_records).to be_empty
        end

    end

    context "with a Work that has TCD metadata defined" do
      it "can set and retrieve a genre value" do
        coll = Collection.new
        coll.creator = ["A Creator"]
        coll.contributor = ["A Contributor"]
        coll.keyword = ["A Keyword"]
        coll.publisher = ["A Publisher"]
        coll.date_created = ["A Date Created"]
        coll.subject = ["A Subject"]
        coll.language = ["A Language"]
        coll.identifier = ["An Identifier"]
        coll.related_url = ["A Related Url"]
        # coll.genre = ["A Work Genre"]
        # coll.bibliography = ["A Work Bibliography"]
        # coll.dris_page_no = ["A Work Dris Page No"]
        # coll.dris_document_no = ["A Work Dris Document No"]
        # coll.dris_unique = ["A Dris Unique"]
        # coll.format_duration = ["A Format Duration"]

        # coll.copyright_status = ["A Copyright Holder"]
        # coll.copyright_note = ["A Copyright Note"]
        # coll.digital_root_number = ["A Digital Root Number"]
        # coll.digital_object_identifier = ["A Digital Object Identifier"]
        # coll.language_code = ["A Language Code"]
        # coll.location_type = ["A Location Type"]
        # coll.shelf_locator = ["A Shelf Locator"]
        # coll.role = ["A Role"]
        # coll.role_code = ["A Role Code"]
        # coll.sponsor = ["A Sponsor"]
        # coll.conservation_history = ["A Conservation History"]
        # coll.publisher_location = ["A Publisher Location"]
        # coll.page_number = ["A Page Number"]
        # coll.page_type = ["A Page Type"]
        # coll.physical_extent = ["A Physical Extent"]
        # coll.support = ["A Support"]
        # coll.medium = ["A Medium"]
        # coll.type_of_work = ["A Type Of Work"]

        # coll.subject_lcsh = ["A Subject LCSH"]
        # coll.subject_local = ["A Subject Local"]
        # coll.subject_name = ["A Subject Name"]
        # coll.alternative_title = ["An Alternative Title"]
        # coll.series_title = ["A Series Title"]
        # coll.collection_title = ["A Collection Title"]

        # coll.provenance = ["A Provenance"]

        # coll.culture = ["A Culture"]
        # coll.county = ["A County"]
        # coll.folder_number = ["A Folder Number"]
        # coll.project_number = ["A Project Number"]
        # coll.order_no = ["An Order No"]
        # coll.total_records = ["A Total Records"]


        expect(coll.creator).to eq (["A Creator"])
        expect(coll.contributor).to eq (["A Contributor"])
        expect(coll.keyword).to eq (["A Keyword"])
        expect(coll.publisher).to eq (["A Publisher"])
        expect(coll.date_created).to eq (["A Date Created"])
        expect(coll.subject).to eq (["A Subject"])
        expect(coll.language).to eq (["A Language"])
        expect(coll.identifier).to eq (["An Identifier"])
        expect(coll.related_url).to eq (["A Related Url"])
        # expect(coll.genre).to eq(["A Work Genre"])
        # expect(coll.bibliography).to eq(["A Work Bibliography"])
        # expect(coll.dris_page_no).to eq(["A Work Dris Page No"])
        # expect(coll.dris_document_no).to eq(["A Work Dris Document No"])
        # expect(coll.dris_unique).to eq(["A Dris Unique"])
        # expect(coll.format_duration).to eq (["A Format Duration"])

        # expect(coll.copyright_status).to eq (["A Copyright Holder"])
        # expect(coll.copyright_note).to eq (["A Copyright Note"])
        # expect(coll.digital_root_number).to eq (["A Digital Root Number"])
        # expect(coll.digital_object_identifier).to eq (["A Digital Object Identifier"])
        # expect(coll.language_code).to eq (["A Language Code"])
        # expect(coll.location_type).to eq (["A Location Type"])
        # expect(coll.shelf_locator).to eq (["A Shelf Locator"])
        # expect(coll.role).to eq (["A Role"])
        # expect(coll.role_code).to eq (["A Role Code"])
        # expect(coll.sponsor).to eq (["A Sponsor"])
        # expect(coll.conservation_history).to eq (["A Conservation History"])
        # expect(coll.publisher_location).to eq (["A Publisher Location"])
        # expect(coll.page_number).to eq (["A Page Number"])
        # expect(coll.page_type).to eq (["A Page Type"])
        # expect(coll.physical_extent).to eq (["A Physical Extent"])
        # expect(coll.support).to eq (["A Support"])
        # expect(coll.medium).to eq (["A Medium"])
        # expect(coll.type_of_work).to eq (["A Type Of Work"])

        # expect(coll.subject_lcsh).to eq (["A Subject LCSH"])
        # expect(coll.subject_local).to eq (["A Subject Local"])
        # expect(coll.subject_name).to eq (["A Subject Name"])
        # expect(coll.alternative_title).to eq  (["An Alternative Title"])
        # expect(coll.series_title).to eq  (["A Series Title"])
        # expect(coll.collection_title).to eq (["A Collection Title"])

        # expect(coll.provenance).to eq (["A Provenance"])

        # expect(coll.culture).to eq (["A Culture"])
        # expect(coll.county).to eq (["A County"])
        # expect(coll.folder_number).to eq (["A Folder Number"])
        # expect(coll.project_number).to eq (["A Project Number"])
        # expect(coll.order_no).to eq (["An Order No"])
        # expect(coll.total_records).to eq (["A Total Records"])

      end
    end

  end
end

# Generated via
#  `rails generate hyrax:work Subseries`
require 'rails_helper'

RSpec.describe Subseries do
  describe "#additional metadata for Trinity College Dublin" do
    context "with a new subseries" do
      it "has no TCD metadata values when it is first created" do
        subseries = Subseries.new
        expect(subseries.abstract).to be_empty
        expect(subseries.genre).to be_empty
        expect(subseries.bibliography).to be_empty
        expect(subseries.dris_page_no).to be_empty
        expect(subseries.dris_document_no).to be_empty
        expect(subseries.dris_unique).to be_empty
        expect(subseries.format_duration).to be_empty

        expect(subseries.copyright_status).to be_empty
        expect(subseries.copyright_note).to be_empty
        expect(subseries.digital_root_number).to be_empty
        expect(subseries.digital_object_identifier).to be_empty

        expect(subseries.location_type).to be_empty
        expect(subseries.shelf_locator).to be_empty

        expect(subseries.sponsor).to be_empty
        expect(subseries.conservation_history).to be_empty
        expect(subseries.publisher_location).to be_empty
        expect(subseries.page_number).to be_empty
        expect(subseries.page_type).to be_empty
        expect(subseries.physical_extent).to be_empty
        expect(subseries.support).to be_empty
        expect(subseries.medium).to be_empty

        expect(subseries.alternative_title).to be_empty
        expect(subseries.series_title).to be_empty
        expect(subseries.collection_title).to be_empty

        expect(subseries.provenance).to be_empty

        expect(subseries.culture).to be_empty
        expect(subseries.county).to be_empty
        expect(subseries.folder_number).to be_empty
        expect(subseries.project_number).to be_empty
        expect(subseries.order_no).to be_empty
        expect(subseries.total_records).to be_empty
        expect(subseries.location).to be_empty
        # 29/03/2019 JL - split creator, genre and subject for Michelle
        expect(subseries.creator_loc).to be_empty
        expect(subseries.creator_local).to be_empty
        expect(subseries.genre_aat).to be_empty
        expect(subseries.genre_tgm).to be_empty
        expect(subseries.subject_lcsh).to be_empty
        expect(subseries.subject_subj_name).to be_empty
        expect(subseries.subject_local_keyword).to be_empty
        # 29/03/2019 JL - experimental belongs_to added to work objects
        expect(subseries.i_belong_to).to be_empty
        expect(subseries.biographical_note).to be_empty
        expect(subseries.finding_aid).to be_empty
        expect(subseries.note).to be_empty
        expect(subseries.sub_fond).to be_empty

      end
    end
    context "with a subseries that has TCD metadata defined" do
      it "can set and retrieve a extended metadata values" do
        subseries = Subseries.new
        subseries.abstract = ["An Abstract"]
        subseries.genre = ["A subseries Genre"]
        subseries.bibliography = ["A subseries Bibliography"]
        subseries.dris_page_no = ["A subseries Dris Page No"]
        subseries.dris_document_no = ["A subseries Dris Document No"]
        subseries.dris_unique = ["A Dris Unique"]
        subseries.format_duration = ["A Format Duration"]

        subseries.copyright_status = ["A Copyright Holder"]
        subseries.copyright_note = ["A Copyright Note"]
        subseries.digital_root_number = ["A Digital Root Number"]
        subseries.digital_object_identifier = ["A Digital Object Identifier"]

        subseries.location_type = ["A Location Type"]
        subseries.shelf_locator = ["A Shelf Locator"]

        subseries.sponsor = ["A Sponsor"]
        subseries.conservation_history = ["A Conservation History"]
        subseries.publisher_location = ["A Publisher Location"]
        subseries.page_number = ["A Page Number"]
        subseries.page_type = ["A Page Type"]
        subseries.physical_extent = ["A Physical Extent"]
        subseries.support = ["A Support"]
        subseries.medium = ["A Medium"]

        subseries.alternative_title = ["An Alternative Title"]
        subseries.series_title = ["A Series Title"]
        subseries.collection_title = ["A Collection Title"]

        subseries.provenance = ["A Provenance"]

        subseries.culture = ["A Culture"]
        subseries.county = ["A County"]
        subseries.folder_number = ["A Folder Number"]
        subseries.project_number = ["A Project Number"]
        subseries.order_no = ["An Order No"]
        subseries.total_records = ["A Total Records"]
        subseries.location = ["A Location"]
        # 29/03/2019 JL - split creator, genre and subject for Michelle
        subseries.creator_loc = ["A Creator - LOC"]
        subseries.creator_local = ["A Creator - local"]
        subseries.genre_aat = ["A Genre - AAT"]
        subseries.genre_tgm = ["A Genre - TGM"]
        subseries.subject_lcsh = ["A Subject - LCSH"]
        subseries.subject_subj_name = ["A Subject - subject name"]
        subseries.subject_local_keyword = ["A Subject - local keyword"]
        # 29/03/2019 JL - experimental belongs_to added to work objects
        subseries.i_belong_to = ["An I_Belong_To link"]
        subseries.biographical_note = ["A Biographical Note"]
        subseries.finding_aid = ["Finding Aid"]
        subseries.note = ["A Note"]
        subseries.sub_fond = ["A Sub Fond"]

        expect(subseries.abstract).to eq(["An Abstract"])
        expect(subseries.genre).to eq(["A subseries Genre"])
        expect(subseries.bibliography).to eq(["A subseries Bibliography"])
        # JL: 2020-04-27 suppress Page No
        #expect(subseries.dris_page_no).to eq(["A subseries Dris Page No"])
        expect(subseries.dris_document_no).to eq(["A subseries Dris Document No"])
        expect(subseries.dris_unique).to eq(["A Dris Unique"])
        expect(subseries.format_duration).to eq (["A Format Duration"])

        expect(subseries.copyright_status).to eq (["A Copyright Holder"])
        expect(subseries.copyright_note).to eq (["A Copyright Note"])
        expect(subseries.digital_root_number).to eq (["A Digital Root Number"])
        expect(subseries.digital_object_identifier).to eq (["A Digital Object Identifier"])

        expect(subseries.location_type).to eq (["A Location Type"])
        expect(subseries.shelf_locator).to eq (["A Shelf Locator"])

        expect(subseries.sponsor).to eq (["A Sponsor"])
        expect(subseries.conservation_history).to eq (["A Conservation History"])
        expect(subseries.publisher_location).to eq (["A Publisher Location"])
        expect(subseries.page_number).to eq (["A Page Number"])
        expect(subseries.page_type).to eq (["A Page Type"])
        expect(subseries.physical_extent).to eq (["A Physical Extent"])
        expect(subseries.support).to eq (["A Support"])
        expect(subseries.medium).to eq (["A Medium"])

        expect(subseries.alternative_title).to eq  (["An Alternative Title"])
        expect(subseries.series_title).to eq  (["A Series Title"])
        expect(subseries.collection_title).to eq (["A Collection Title"])

        expect(subseries.provenance).to eq (["A Provenance"])

        expect(subseries.culture).to eq (["A Culture"])
        expect(subseries.county).to eq (["A County"])
        expect(subseries.folder_number).to eq (["A Folder Number"])
        expect(subseries.project_number).to eq (["A Project Number"])
        expect(subseries.order_no).to eq (["An Order No"])
        expect(subseries.total_records).to eq (["A Total Records"])
        expect(subseries.location).to eq (["A Location"])
        # 29/03/2019 JL - split creator, genre and subject for Michelle
        expect(subseries.creator_loc).to eq (["A Creator - LOC"])
        expect(subseries.creator_local).to eq (["A Creator - local"])
        expect(subseries.genre_aat).to eq (["A Genre - AAT"])
        expect(subseries.genre_tgm).to eq (["A Genre - TGM"])
        expect(subseries.subject_lcsh).to eq (["A Subject - LCSH"])
        expect(subseries.subject_subj_name).to eq (["A Subject - subject name"])
        expect(subseries.subject_local_keyword).to eq (["A Subject - local keyword"])
        # 29/03/2019 JL - experimental belongs_to added to work objects
        expect(subseries.i_belong_to).to eq (["An I_Belong_To link"])
        expect(subseries.biographical_note).to eq (["A Biographical Note"])
        expect(subseries.finding_aid).to eq (["Finding Aid"])
        expect(subseries.note).to eq (["A Note"])
        expect(subseries.sub_fond).to eq (["A Sub Fond"])

      end
    end
  end

end

# Generated via
#  `rails generate hyrax:work Work`
require 'rails_helper'

RSpec.describe Work do
  # 20-11-2018 JL:
  describe "#additional metadata for Trinity College Dublin" do
    context "with a new Work" do
      it "has no TCD metadata values when it is first created" do
        work = Work.new
        expect(work.genre).to be_empty
        expect(work.bibliography).to be_empty
        expect(work.dris_page_no).to be_empty
        expect(work.dris_document_no).to be_empty
        expect(work.dris_unique).to be_empty
        expect(work.format_duration).to be_empty
        expect(work.format_resolution).to be_empty
        expect(work.copyright_holder).to be_empty
        expect(work.digital_root_number).to be_empty
        expect(work.digital_object_identifier).to be_empty
        expect(work.language_code).to be_empty
        expect(work.location_type).to be_empty
        expect(work.shelf_locator).to be_empty
        expect(work.role).to be_empty
        expect(work.role_code).to be_empty
        expect(work.sponsor).to be_empty
        expect(work.conservation_history).to be_empty
        expect(work.publisher_location).to be_empty
        expect(work.page_number).to be_empty
        expect(work.page_type).to be_empty
        expect(work.physical_extent).to be_empty
      end
    end
    context "with a Work that has TCD metadata defined" do
      it "can set and retrieve a genre value" do
        work = Work.new
        work.genre = ["A Work Genre"]
        work.bibliography = ["A Work Bibliography"]
        work.dris_page_no = ["A Work Dris Page No"]
        work.dris_document_no = ["A Work Dris Document No"]
        work.dris_unique = ["A Dris Unique"]
        work.format_duration = ["A Format Duration"]
        work.format_resolution = ["A Format Resolution"]
        work.copyright_holder = ["A Copyright Holder"]
        work.digital_root_number = ["A Digital Root Number"]
        work.digital_object_identifier = ["A Digital Object Identifier"]
        work.language_code = ["A Language Code"]
        work.location_type = ["A Location Type"]
        work.shelf_locator = ["A Shelf Locator"]
        work.role = ["A Role"]
        work.role_code = ["A Role Code"]
        work.sponsor = ["A Sponsor"]
        work.conservation_history = ["A Conservation History"]
        work.publisher_location = ["A Publisher Location"]
        work.page_number = ["A Page Number"]
        work.page_type = ["A Page Type"]
        work.physical_extent = ["A Physical Extent"]

        expect(work.genre).to eq(["A Work Genre"])
        expect(work.bibliography).to eq(["A Work Bibliography"])
        expect(work.dris_page_no).to eq(["A Work Dris Page No"])
        expect(work.dris_document_no).to eq(["A Work Dris Document No"])
        expect(work.dris_unique).to eq(["A Dris Unique"])
        expect(work.format_duration).to eq (["A Format Duration"])
        expect(work.format_resolution).to eq (["A Format Resolution"])
        expect(work.copyright_holder).to eq (["A Copyright Holder"])
        expect(work.digital_root_number).to eq (["A Digital Root Number"])
        expect(work.digital_object_identifier).to eq (["A Digital Object Identifier"])
        expect(work.language_code).to eq (["A Language Code"])
        expect(work.location_type).to eq (["A Location Type"])
        expect(work.shelf_locator).to eq (["A Shelf Locator"])
        expect(work.role).to eq (["A Role"])
        expect(work.role_code).to eq (["A Role Code"])
        expect(work.sponsor).to eq (["A Sponsor"])
        expect(work.conservation_history).to eq (["A Conservation History"])
        expect(work.publisher_location).to eq (["A Publisher Location"])
        expect(work.page_number).to eq (["A Page Number"])
        expect(work.page_type).to eq (["A Page Type"])
        expect(work.physical_extent).to eq (["A Physical Extent"])

      end
    end
  end





end

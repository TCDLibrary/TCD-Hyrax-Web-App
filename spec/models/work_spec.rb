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
        #expect(work.page_type).to be_empty
        expect(work.page_no).to be_empty
        expect(work.catalog_no).to be_empty
      end
    end
    context "with a Work that has TCD metadata defined" do
      it "can set and retrieve a genre value" do
        work = Work.new
        work.genre = ["A Work Genre"]
        work.bibliography = ["A Work Bibliography"]
        work.dris_page_no = ["A Work Dris Page No"]
        work.dris_document_no = ["A Work Dris Document No"]
        #work.page_type = ["A Work Page Type"]
        work.page_no = ["A Work Page No"]
        work.catalog_no = ["A Work Catalog No"]
        expect(work.genre).to eq(["A Work Genre"])
        expect(work.bibliography).to eq(["A Work Bibliography"])
        byebug
        expect(work.dris_page_no).to eq(["A Work Dris Page No"])
        expect(work.dris_document_no).to eq(["A Work Dris Document No"])
        #expect(work.page_type).to eq(["A Work Page Type"])
        expect(work.page_no).to eq(["A Work Page No"])
        expect(work.catalog_no).to eq(["A Work Catalog No"])
      end
    end
  end





end

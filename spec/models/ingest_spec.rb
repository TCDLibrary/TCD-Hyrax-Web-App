require 'rails_helper'

RSpec.describe Ingest do
  # 16-08-2019 JL:
  describe "ingesting for Trinity College Dublin" do
    context "with a new Ingest" do
      it "has no values when it is first created" do
        ingest = Ingest.new
        expect(ingest.xml_file_name).to be_empty
        expect(ingest.new_work_type).to be_empty
        expect(ingest.parent_type).to be_empty
        expect(ingest.parent_id).to be_empty
        expect(ingest.image_type).to be_empty

      end
    end
    context "with an Ingest that has been populated" do
      it "can set and retrieve a values" do
        ingest = Ingest.new
        ingest.xml_file_name = ["An XML file name"]
        ingest.new_work_type = ["A new work type"]
        ingest.parent_type = ["A parent type"]
        ingest.parent_id = ["A parent id"]
        ingest.image_type = ["An image format"]

        expect(ingest.xml_file_name).to include "An XML file name"
        expect(ingest.new_work_type).to include "A new work type"
        expect(ingest.parent_type).to include "A parent type"
        expect(ingest.parent_id).to include "A parent id"
        expect(ingest.image_type).to include "An image format"

      end
    end
  end

end

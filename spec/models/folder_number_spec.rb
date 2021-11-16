require 'rails_helper'

RSpec.describe FolderNumber, type: :model do

  describe "create" do
    context "a new FolderNumber" do
      it "has no content" do
        folder = FolderNumber.new
        expect(folder.project_id).to be_nil
        expect(folder.root_filename).to be_nil
        expect(folder.title).to be_nil
        expect(folder.job_type).to be_nil
        expect(folder.suitable_for_ingest).to be_nil
        expect(folder.project_name).to be_nil
        expect(folder.status).to be_nil
        expect(folder.created_by).to be_nil
      end
    end

    context "a new FolderNumber" do
      it "can set content values" do
        folder = FolderNumber.new

        folder.project_id = 1
        folder.root_filename = "Root Filename"
        folder.title = "Title"
        folder.job_type = "Job Type"
        folder.suitable_for_ingest = "Y"
        folder.project_name = "Project Name"
        folder.status = "Status"
        folder.created_by = "Created By"

        expect(folder.project_id).to eq 1
        expect(folder.root_filename).to eq ("Root Filename")
        expect(folder.title).to eq ("Title")
        expect(folder.job_type).to eq ("Job Type")
        expect(folder.suitable_for_ingest).to eq ("Y")
        expect(folder.project_name).to eq ("Project Name")
        expect(folder.status).to eq ("Status")
        expect(folder.created_by).to eq ("Created By")
      end
    end

  end

end

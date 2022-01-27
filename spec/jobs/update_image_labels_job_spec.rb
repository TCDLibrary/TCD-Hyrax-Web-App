require 'rails_helper'

RSpec.describe UpdateImageLabelsJob, type: :job do

  describe "call update image labels job" do
    context "where some fileset exists" do
      it "can be called and replaces fileset title" do

        fs = FileSet.new
        fs.title = ["A Title"]
        fs.label = "ALabel.jpg"
        fs.save

        wo = Work.new
        wo.title = ["A Title"]
        wo.creator = ["A Creator"]
        wo.keyword = ["A Keyword"]
        wo.members << fs
        wo.save

        label = ImageDisplayName.new
        label.object_id = wo.id
        label.image_file_name = "ALabel.jpg"
        label.image_display_text = "New Image Label"
        label.save

        result = UpdateImageLabelsJob.perform_now(wo)
        expect(fs.title).to eq ["New Image Label"]

      end
    end

 end

end

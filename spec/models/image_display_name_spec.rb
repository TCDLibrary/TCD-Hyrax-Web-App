require 'rails_helper'

RSpec.describe ImageDisplayName, type: :model do

  describe "create" do
    context "a new ImageDisplayName" do
      it "has no content" do
        disp = ImageDisplayName.new
        expect(disp.image_file_name).to be_nil
        expect(disp.image_display_text).to be_nil

      end
    end

    context "a new ImageDisplayName" do
      it "can set content values" do
        disp = ImageDisplayName.new

        disp.image_file_name = "101_0068.JPG"
        disp.image_display_text = "Sample Image Label"

        expect(disp.image_file_name).to eq ("101_0068.JPG")
        expect(disp.image_display_text).to eq ("Sample Image Label")

      end
    end

  end

end

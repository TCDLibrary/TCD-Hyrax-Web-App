require 'rails_helper'

RSpec.describe FileSet do

  # JL : 19-07-2019 :
  describe "#technical metadata when ingesting jpg images" do
    context "with a new FileSet" do
      it "has no technical metadata values when it is first created" do
        fs = FileSet.new
        expect(fs.camera_model).to be_nil
        expect(fs.camera_make).to be_nil
        expect(fs.date_taken).to be_nil
        expect(fs.exposure_time).to be_nil
        expect(fs.f_number).to be_nil
        expect(fs.iso_speed_rating).to be_nil
        expect(fs.flash).to be_nil
        expect(fs.exposure_program).to be_nil
        expect(fs.focal_length).to be_nil
        expect(fs.software).to be_nil
        expect(fs.fedora_sha1).to be_nil
      end
    end
    context "with a FileSet that has techincal metadata defined" do
      it "can set and retrieve technical metadata values" do
        fs = FileSet.new
        fs.camera_model = "A Model"
        fs.camera_make = "A Make"
        fs.date_taken = Date.today
        fs.exposure_time = "Exp Time"
        fs.f_number = "F Num"
        fs.iso_speed_rating = "ISO num"
        fs.flash = "A Flash val"
        fs.exposure_program = "Exp Pgm"
        fs.focal_length = "Focal len"
        fs.software = "Software"
        fs.fedora_sha1 ="1234567890abcd"

        expect(fs.camera_model).to eq("A Model")
        expect(fs.camera_make).to eq("A Make")
        expect(fs.date_taken).to eq(Date.today)
        expect(fs.exposure_time).to eq("Exp Time")
        expect(fs.f_number).to eq("F Num")
        expect(fs.iso_speed_rating).to eq("ISO num")
        expect(fs.flash).to eq ("A Flash val")
        expect(fs.exposure_program).to eq ("Exp Pgm")
        expect(fs.focal_length).to eq ("Focal len")
        expect(fs.software).to eq ("Software")
        expect(fs.fedora_sha1).to eq ("1234567890abcd")

      end
    end
  end
end

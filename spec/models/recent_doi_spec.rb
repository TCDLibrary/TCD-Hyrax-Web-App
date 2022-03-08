require 'rails_helper'

RSpec.describe RecentDoi, type: :model do
  describe "create" do
    context "a new RecentDoi" do
      it "has no content" do
        recent = RecentDoi.new
        expect(recent.dris_unique).to be_nil
        expect(recent.doi).to be_nil

      end
    end

    context "a new ImageDisplayName" do
      it "can set content values" do
        recent = RecentDoi.new

        recent.dris_unique = "123456789"
        recent.doi = "https://doi.org/10.81003/987654321"

        expect(recent.dris_unique).to eq ("123456789")
        expect(recent.doi).to eq ("https://doi.org/10.81003/987654321")


      end
    end

  end

end

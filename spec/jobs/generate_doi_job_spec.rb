require 'rails_helper'

RSpec.describe GenerateDoiJob, type: :job do
    describe "generate a draft doi then remove it" do
      context "with a Work that has some metadata defined" do
        it "can set and store a DOI" do
          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator"]
          work.save
          GenerateDoiJob.perform_now(work)
          expect(work.doi).to include work.id
          DeleteDraftDoiJob.perform_now(work)
          expect(work.doi).to be_empty
        end
      end

      context "with a Work that has some metadata defined" do
        it "doesnt overwrite existing DOI" do
          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator"]
          work.doi = "A DOI"
          work.save
          GenerateDoiJob.perform_now(work)
          expect(work.doi).to eq "A DOI"
        end
      end

   end
end

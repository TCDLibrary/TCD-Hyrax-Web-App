require 'rails_helper'

RSpec.describe GenerateDoiTreeJob, type: :job do
  describe "call datacite doi generator" do
    context "with a Work that has some metadata defined" do
      it "can be called" do
        work = Work.new
        work.title = ["A Title - one level"]
        work.creator = ["A Creator"]
        work.visibility = 'open'
        work.save
        result = GenerateDoiTreeJob.perform_now(work)
        #byebug

        expect(work.doi).to include work.id

        DeleteDraftDoiJob.perform_now(work)
        expect(work.doi).to be_empty

      end
    end

    context "with nested works" do
      it "can run recursively" do
        work = Work.new
        work.title = ["A Title - top level"]
        work.creator = ["A Creator"]
        work.visibility = 'open'
        work.save
        child = Work.new
        child.title = ["A Title - child level"]
        child.creator = ["A Creator"]
        child.visibility = 'open'
        child.save
        work.members << child
        result = GenerateDoiTreeJob.perform_now(work)
        #byebug

        expect(work.doi).to include work.id
        expect(child.doi).to include child.id
        DeleteDraftDoiJob.perform_now(work)
        DeleteDraftDoiJob.perform_now(child)
      #  expect(work.doi).to be_empty

      end
    end

    context "with a private Work" do
      it "doesnt write a DOI" do
        work = Work.new
        work.title = ["A Private Title"]
        work.creator = ["A Private Creator"]
        work.visibility = 'restricted'
        work.save
        GenerateDoiJob.perform_now(work)
        expect(work.doi).to be_nil
      end
    end

 end
end

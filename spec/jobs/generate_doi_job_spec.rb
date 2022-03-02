require 'rails_helper'

RSpec.describe GenerateDoiJob, type: :job do
    describe "generate a draft doi then remove it" do
      context "with a Work that has some metadata defined" do
        it "can set and store a DOI" do
          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator", "Another Creator"]
          work.resource_type = ["text", "image"]
          work.subject = ["Ireland--History", "Ireland--Civilization", "Ireland. Constitution"]
          work.keyword = ["Unassigned", "unassigned", "a keyword"]
          work.abstract = ["Presented here are a number of Arabic language manuscripts from the collection held in the Manuscripts & Research Archives Library"]
          work.language = ["english"]
          work.identifier = ["IE TCD MS 2689"]
          work.visibility = 'open'

          work.save
          GenerateDoiJob.perform_now(work.id)
          updated_work = Work.find(work.id)
          expect(updated_work.doi).to include work.id
          DeleteDraftDoiJob.perform_now(updated_work)
          expect(updated_work.doi).to be_empty
        end
      end

      context "with a Work that has some metadata defined" do
        it "doesnt overwrite existing DOI" do
          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator"]
          work.doi = "A DOI"
          work.visibility = 'open'
          work.save
          GenerateDoiJob.perform_now(work.id)
          updated_work = Work.find(work.id)
          expect(updated_work.doi).to eq "A DOI"
        end
      end

      context "with a private Work" do
        it "doesnt write a DOI" do
          work = Work.new
          work.title = ["A Private Title"]
          work.creator = ["A Private Creator"]
          work.visibility = 'restricted'
          work.save
          GenerateDoiJob.perform_now(work.id)
          updated_work = Work.find(work.id)
          expect(updated_work.doi).to be_nil
        end
      end

      context "with a Work that has a Sierra bib reference" do
        it "it empties the RecentDoi table after itself" do
          # RecentDoi table holds new DOIs (created this week)
          before_count = RecentDoi.count
          recent = RecentDoi.new
          recent.dris_unique = "b23456789"
          recent.doi = "https://doi.org/10.81003/987654321"
          recent.save
          count = RecentDoi.count
          expect(count).to eq(before_count + 1)

          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator", "Another Creator"]
          work.resource_type = ["text", "image"]
          work.subject = ["Ireland--History", "Ireland--Civilization", "Ireland. Constitution"]
          work.keyword = ["Unassigned", "unassigned", "a keyword"]
          work.abstract = ["Presented here are a number of Arabic language manuscripts from the collection held in the Manuscripts & Research Archives Library"]
          work.language = ["english"]
          work.identifier = ["IE TCD MS 2689"]
          work.visibility = 'open'
          work.dris_unique = ['b12345678']
          work.save

          GenerateDoiJob.perform_now(work.id)
          updated_work = Work.find(work.id)
          expect(updated_work.doi).to include work.id
          DeleteDraftDoiJob.perform_now(updated_work)
          expect(updated_work.doi).to be_empty

          # The SendDoiToSierraJob should clear down the RecentDoi in prep for next week
          SendDoiToSierraJob.perform_now
          count = RecentDoi.count
          expect(count).to eq(0)
        end
      end


   end
end

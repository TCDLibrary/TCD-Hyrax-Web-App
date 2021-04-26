require 'rails_helper'

RSpec.describe ExportDublinCoreJob, type: :job do
    describe "call dublin core export" do
      context "with a Work that has some metadata defined" do
        it "can be called" do
          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator"]
          work.save
          work_array = [work]
          result = ExportDublinCoreJob.perform_now(work_array)
          output = Rails.application.config.export_folder + work.id + "-DC-" + Date.today.to_s(:db) + ".xml"
          #byebug
          expect(File).to exist(output)
        end
      end

      context "with an array of Works" do
        it "can be called" do
          work = Work.new
          work.title = ["A Title"]
          work.creator = ["A Creator"]
          work.save
          wo2 = Work.new
          wo2.title = ["Another Title"]
          wo2.creator = ["Another Creator"]
          wo2.save
          work_array = [work, wo2]
          result = ExportDublinCoreJob.perform_now(work_array)
          output = Rails.application.config.export_folder + work.id + "-DC-" + Date.today.to_s(:db) + ".xml"
          expect(File).to exist(output)
          output2 = Rails.application.config.export_folder + wo2.id + "-DC-" + Date.today.to_s(:db) + ".xml"
          expect(File).to exist(output2)
        end
      end
   end
end

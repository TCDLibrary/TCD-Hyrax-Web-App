require 'rails_helper'

RSpec.describe ExportDcTreeJob, type: :job do
  describe "call dublin core export" do
    context "with a Work that has some metadata defined" do
      it "can be called" do
        work = Work.new
        work.title = ["A Title"]
        work.creator = ["A Creator"]
        work.save
        result = ExportDcTreeJob.perform_now(work.id)
        output = Rails.application.config.export_folder + work.id + "-DC-" + Date.today.to_s(:db) + ".xml"
        #byebug
        expect(File).to exist(output)
      end
    end
 end
end

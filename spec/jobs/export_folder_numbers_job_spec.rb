require 'rails_helper'

RSpec.describe ExportFolderNumbersJob, type: :job do
    describe "call folder number export" do
      context "where some folders are defined" do
        it "can be called" do
          fol = FolderNumber.new
          fol.project_id = 99
          fol.title = ["A Title"]
          fol.note = ["A Note"]
          fol.save
          folder_numbers = FolderNumber.all.to_a

          result = ExportFolderNumbersJob.perform_now(folder_numbers)
          output = Rails.application.config.export_folder + "FolderNumbersExport-" + Date.today.to_s(:db) + ".txt"
          #byebug
          expect(File).to exist(output)
        end
      end

   end
end

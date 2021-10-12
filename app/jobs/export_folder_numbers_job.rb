class ExportFolderNumbersJob < ApplicationJob
  queue_as :export

  def perform(folder_numbers)
    #byebug
    records = "Project ID / Folder No.|MS or LCN No. /Root Filename|Title|Job Type|Suitable For Ingest?|X=Done / Issue|Notes|Created By\n"
    #byebug
    folder_numbers.each do | folder |
      records << folder.project_id.to_s + "|" + (folder.root_filename || "") + "|" + (folder.title || "") + "|" + (folder.job_type || "") + "|" + (folder.suitable_for_ingest || "") + "|" + (folder.status || "") + "|" + (folder.note || "") + "|" + (folder.created_by || "") + "\n"
    end
    #byebug
    File.open(Rails.application.config.export_folder + "FolderNumbersExport-" + Date.today.to_s(:db) + ".txt", "w") { |f| f.write records }
  end

end

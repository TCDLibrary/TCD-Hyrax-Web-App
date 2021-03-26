class ExportDublinCoreJob < ApplicationJob
  queue_as :export

  def perform(work_array)

    work_array.each do | work |
      #work = work_array[0]
      puts work.id

      our_xml = make_dublin_core(work)

      #make a file with name Rails.application.config.export_folder + work.id + "-DublinCore-" + DateTime.now.to_s(:db) + ".xml"
      File.open(Rails.application.config.export_folder + work.id + "-DublinCore-" + Date.today.to_s(:db) + ".xml", "w") { |f| f.write our_xml }

      #byebug
    end
  end

  private

  def make_dublin_core(work)

    if !work.id.blank?
      builder = work.to_dublin_core
      return builder

    end # if !work.id.blank?

  end

end

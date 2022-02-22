class UpdateImageLabelsJob < ApplicationJob
  queue_as :import

  def perform(work)

    # Loop through the images attached to the work
    work.file_sets.each do | afile |

      #  Lookup the filename on image labels table
         display_name = ImageDisplayName.where(object_id: "#{work.id}", image_file_name: "#{afile.label}")

      # If label found, update the fileset
         if display_name.count > 0 && afile.title.first != display_name.first.image_display_text
           # find or make a method on the fileset to do this update?
           afile.title = [display_name.first.image_display_text]
           afile.save
         end

    end

    # Make sure I update Solr and manifest.json file
    # Do I need to expire a previous manifest file?


  end
end

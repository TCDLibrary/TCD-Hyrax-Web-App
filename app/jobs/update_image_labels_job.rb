class UpdateImageLabelsJob < ApplicationJob
  queue_as :import

  def perform(work)

    byebug
    # Loop through the images attached to the work

    #    Call job to update an image Title?
    # OR
    #    Update the image Title here?
    #
    # End

    # NOTE: Try to use existing methods on the FileSet object.

    # Make sure I update Solr and manifest.json file
    # Do I need to expire a previous manifest file?


  end
end

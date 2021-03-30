class ExportBulkController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_admin!

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def dublinCore
    objectId = params[:id]
    prep_for_export_job(objectId)
    flash[:notice] = "Bulk Export has been submitted. Files will be saved in " + Rails.application.config.export_folder
    redirect_back(fallback_location: root_path)
  end

  def prep_for_export_job(objectId)

    obj = ActiveFedora::Base.find(objectId, cast: true)
    #byebug
    if obj.work?
      work_array = [obj]
      ExportDublinCoreJob.perform_later(work_array)

      if obj.members.size > 0
      # need to go down through the tree recursively
        #byebug
        obj.members.each do | child |
          prep_for_export_job(child.id)
        end
      end

    end
  end

end

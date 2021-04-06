class ExportBulkController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_admin!

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def dublinCore
    objectId = params[:id]
    #prep_for_export_job(objectId)
    ExportDcTreeJob.perform_later(objectId)
    flash[:notice] = "Bulk Export has been submitted. Files will be saved in " + Rails.application.config.export_folder
    #redirect_to main_app.root_url
    #redirect_to [main_app, curation_concern]
    redirect_back(fallback_location: root_path)
  end

end

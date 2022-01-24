class ImageDisplayNamesController < ApplicationController

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!
  skip_before_action :verify_authenticity_token

  with_themed_layout 'dashboard'

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def new
    add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
    add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    add_breadcrumb t(:'hyrax.admin.sidebar.works'), hyrax.my_works_path
    add_breadcrumb request.params[:id], Rails.application.config.persistent_hostpath + request.params[:id]
    #add_breadcrumb 'Manage Image Display Names', new_image_display_name_path
  end

  def create
    message = "Image labels recorded. Labels will update in batch jobs. See Sidekiq."
    byebug
    rows = params[:excel_data]
    # obj = ActiveFedora::Base.find(params[:objid], cast: true)
    # obj.file_sets[0].id

    #=> delete existing rows for this work id?
    #ImageDisplayName.where(:object_id => params[:objid]).destroy_all
    byebug
    begin
      rows.each_line do | a_row |
          byebug
          cols = a_row.split("\t")
          puts cols[0] + "=>" + cols[1]
          ImageDisplayName.where(:object_id => params[:objid], :image_file_name => cols[0].strip).destroy_all
          #=> insert table row for this excel row
          newrec = ImageDisplayName.new
          newrec.object_id = params[:objid]
          newrec.image_file_name = cols[0].strip
          newrec.image_display_text = cols[1].strip
          newrec.save
          #=> clean up the data so that I don't get code injections
      end
    rescue StandardError => e
      byebug
      message = "ERROR: " + params[:objid] + " => " + "ImageDisplayNamesController => " + e.to_s
    end

    # new that the data is stored, I need to kick of a job that processes the work and its filesets.
    object = ActiveFedora::Base.find(params[:objid], cast: true)
    UpdateImageLabelsJob.perform_later(object)
    # then send a message back to the screen and redirect to the work page.
    byebug
    redirect_to hyrax.my_works_path, notice: message
  end
end

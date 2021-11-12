class FolderNumbersController < ApplicationController
  include Hyrax::ThemedLayoutController

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!

  with_themed_layout 'dashboard'

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def index
    add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
    add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    add_breadcrumb 'Folder No/Project ID', folder_numbers_path
    @folder_numbers = FolderNumber.all
  end

  def show
    add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
    add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    add_breadcrumb 'Folder No/Project ID', folder_numbers_path
    @folder_number = FolderNumber.find(params[:id])
  end

  def new
    add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
    add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    add_breadcrumb 'Folder No/Project ID', folder_numbers_path
    @next = (FolderNumber.maximum("project_id") || 0) + 1
    @folder_number = FolderNumber.new({:project_id => @next, :suitable_for_ingest => 'No'})
  end

  def create
    @folder_number = FolderNumber.new(folder_number_params)
    if @folder_number.save
      redirect_to folder_numbers_path, notice: "Folder No/Project ID #{@folder_number.project_id.to_s} was successfully created."
    else
      render('new') # redraws the form, doesn't rerun new method
    end
  end

  def edit
    add_breadcrumb t(:'hyrax.controls.home'), main_app.root_path
    add_breadcrumb t(:'hyrax.dashboard.breadcrumbs.admin'), hyrax.dashboard_path
    add_breadcrumb 'Folder No/Project ID', folder_numbers_path
    @folder_number = FolderNumber.find(params[:id])
  end

  def update
    @folder_number = FolderNumber.find(params[:id])
    if @folder_number.update_attributes(folder_number_params)
      redirect_to folder_number_path(@folder_number), notice: "Folder No/Project ID #{@folder_number.project_id.to_s} was successfully updated."
    else
      render('edit') # redraws the form, doesn't rerun new method #
    end
  end

  def delete
    @folder_number = FolderNumber.find(params[:id])
  end

  def destroy
    @folder_number = FolderNumber.find(params[:id])
    @folder_number.destroy
    redirect_to folder_numbers_path, notice: "Folder No/Project ID #{@folder_number.project_id.to_s} was successfully deleted."
  end

  def export
    folder_numbers = FolderNumber.all.to_a
    #byebug
    ExportFolderNumbersJob.perform_later(folder_numbers)
    #flash[:notice] = "Folder No/Project ID data export has been submitted. Files will be saved in " + Rails.application.config.export_folder
    #redirect_to main_app.root_url
    #redirect_to [main_app, curation_concern]
    redirect_to folder_numbers_path, notice: "Folder No/Project ID data export has been submitted. Files will be saved in " + Rails.application.config.export_folder
    #redirect_back(fallback_location: root_path)
  end

 private

  def folder_number_params
    params.require(:folder_number).permit(:project_id, :root_filename, :title, :job_type, :suitable_for_ingest, :project_name, :status, :note, :created_by)
  end
end

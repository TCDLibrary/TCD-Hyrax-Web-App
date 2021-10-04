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
    @folder_numbers = FolderNumber.sorted
  end

  def show
    @folder_number = FolderNumber.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def export
  end
end

class DoiBlockerListsController < ApplicationController
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
    add_breadcrumb 'DOI Blocker List', doi_blocker_lists_path
    @doi_blocker_lists = DoiBlockerLists.sorted
  end

  def create
  end

  def update
  end

#  private
#  def hyrax_checksum_params
  #  params.require(:hyrax_checksum).permit(:last_fixity_result, :last_fixity_check)
#  end
end

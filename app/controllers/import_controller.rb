class ImportController < ApplicationController
  include Hydra::Controller::ControllerBehavior

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def picker

    parent_type = 'no_parent'
    parent_id = '000000000'


    new_object_type = params[:import_object_type]
    # base_folder = 'spec/fixtures/'
    sub_folder = params[:sub_folder]
    file_name = params[:picker]

    parent_id = params[:parent_code]
    parent_type = params[:parent_type]

    if parent_type ==  'no_parent'
      parent_id = '000000000'
    end

    # TODO : Need to get this controller to work with Folios, Works and Collections - depending on input

    #work_file_example = 'spec/fixtures/Named_Collection_Example_OBJECT RECORDS_v3.6_20181207.xml'

    #file_example = 'spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml'
    #parent = 'f1881k888'
    #byebug

    if new_object_type == "folio(s)"
      XmlFolioImporter.new(file_name, parent_id, parent_type, sub_folder).import
    end

    if new_object_type == "work(s)"
        XmlWorkImporter.new(file_name, parent_id, parent_type, sub_folder).import
    end

    if new_object_type == "collection(s)"
        XmlCollectionImporter.new(work_file_example).import
    end


  end


  def index

  end
end

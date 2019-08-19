class IngestsController < ApplicationController

  # JL : 14/02/2019 Put security (admin level) around the ingest screen
  before_action :authenticate_user!
  before_action :ensure_admin!

  def ensure_admin!
      authorize! :read, :admin_dashboard
  end

  def index
    @ingests = Ingest.sorted
  end

  def show
    @ingest = Ingest.find(params[:id])
  end

  def new
    @ingest = Ingest.new
  end

  def create
    # Instantiate the new object
    @ingest = Ingest.new(ingest_params)
    @ingest.submitted_by = current_user
    # Save it
    if @ingest.save
      # If save succeeds, trigger the ingest and redirect to index

      if @ingest.new_work_type == "folio(s)"
        #admin_set_id =  AdminSet.find_or_create_default_admin_set_id
        artefactClass = Folio
        FoxmlImporter.new(@ingest.object_model_type, current_user, @ingest.xml_file_name, @ingest.parent_id, @ingest.parent_type, @ingest.image_type).import(artefactClass)
      end

      if @ingest.new_work_type == "subseries(s)"
        artefactClass = Subseries
        FoxmlImporter.new(@ingest.object_model_type, current_user, @ingest.xml_file_name, @ingest.parent_id, @ingest.parent_type, @ingest.image_type).import(artefactClass)
      end

      if @ingest.new_work_type == "work(s)"
          artefactClass = Work
          FoxmlImporter.new(@ingest.object_model_type, current_user, @ingest.xml_file_name, @ingest.parent_id, @ingest.parent_type, @ingest.image_type).import(artefactClass)
      end

      flash[:notice] = 'Ingest request created.'
      redirect_to(ingests_path)
    else
      # If save fails, redirect to form so user can fix it
      flash[:notice] = 'An error occurred. Ingest request not created.'
      render('new')
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

  def ingest_params
    params.require(:ingest).permit(:object_model_type, :xml_file_name,
          :new_work_type, :parent_type, :parent_id, :image_type)
  end

end

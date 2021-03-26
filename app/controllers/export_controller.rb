class ExportController < ApplicationController
  include Hydra::Controller::ControllerBehavior
  #require 'iso-639'

  def dublinCore

    objectId = params[:id]

    obj  = ActiveFedora::Base.find(objectId, cast: true)

    builder = obj.to_dublin_core

    respond_to do |format|
     format.html
     format.xml { render xml: builder  }
   end

  end
end

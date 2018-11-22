# Generated via
#  `rails generate hyrax:work Folio`
module Hyrax
  # Generated controller for Folio
  class FoliosController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Folio

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::FolioPresenter
  end
end

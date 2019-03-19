# Generated via
#  `rails generate hyrax:work Subseries`
module Hyrax
  # Generated controller for Subseries
  class SubseriesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Subseries

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::SubseriesPresenter
  end
end

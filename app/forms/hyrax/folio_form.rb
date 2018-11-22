# Generated via
#  `rails generate hyrax:work Folio`
module Hyrax
  # Generated form for Folio
  class FolioForm < Hyrax::Forms::WorkForm
    self.model_class = ::Folio
    self.terms += [:resource_type]
  end
end

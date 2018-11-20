# Generated via
#  `rails generate hyrax:work Work`
module Hyrax
  # Generated form for Work
  class WorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::Work
    self.terms += [:resource_type]

    # 20-11-2018 JL:
    self.terms += [:genre]
    self.terms += [:bibliography]
    self.terms += [:dris_page_no]
    self.terms += [:dris_document_no]
    self.terms += [:page_no]
    #self.terms += [:page_type]
    self.terms += [:catalog_no]
  end
end

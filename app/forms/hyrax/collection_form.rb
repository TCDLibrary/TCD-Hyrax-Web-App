# JL: 13/12/2018 create form for Collection
module Hyrax
  class CollectionForm < Hyrax::Forms::CollectionForm
    self.model_class = ::Collection
    # self.terms += [:genre]
  end
end

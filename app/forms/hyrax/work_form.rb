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
    self.terms += [:dris_unique]
    self.terms += [:format_duration]
    self.terms += [:format_resolution]
    self.terms += [:copyright_holder]
    self.terms += [:digital_root_number]
    self.terms += [:digital_object_identifier]
    self.terms += [:language_code]
    self.terms += [:location_type]
    self.terms += [:shelf_locator]
    self.terms += [:role]
    self.terms += [:role_code]
    self.terms += [:sponsor]
    self.terms += [:conservation_history]
    self.terms += [:publisher_location]
    self.terms += [:page_number]
    self.terms += [:page_type]
    self.terms += [:physical_extent]

  end
end

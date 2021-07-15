# Generated via
#  `rails generate hyrax:work Subseries`
module Hyrax
  # Generated form for Subseries
  class SubseriesForm < Hyrax::Forms::WorkForm
    self.model_class = ::Subseries
    self.terms += [:dris_unique]
    self.terms += [:alternative_title]
    self.terms += [:publisher_location]
    self.terms += [:physical_extent]
    self.terms += [:format_duration]
    self.terms += [:abstract]
    self.terms += [:series_title]
    self.terms += [:collection_title]
    self.terms += [:provenance]
    self.terms += [:sponsor]
    self.terms += [:genre]
    self.terms += [:resource_type]
    self.terms += [:medium]
    self.terms += [:support]
    self.terms += [:culture]
    self.terms += [:bibliography]
    self.terms += [:conservation_history]
    self.terms += [:location_type]
    self.terms += [:location]
    self.terms += [:shelf_locator]
    self.terms += [:copyright_status]
    self.terms += [:copyright_note]
    self.terms += [:folder_number]
    self.terms += [:project_number]
    self.terms += [:digital_root_number]
    self.terms += [:digital_object_identifier]
    self.terms += [:dris_page_no]
    self.terms += [:dris_document_no]
    self.terms += [:page_number]
    self.terms += [:page_type]
    self.terms += [:order_no]
    self.terms += [:total_records]
    self.terms += [:county]
    self.terms += [:biographical_note]
    self.terms += [:finding_aid]
    self.terms += [:note] 

  end
end

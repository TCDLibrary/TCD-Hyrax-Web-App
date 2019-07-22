# Generated via
#  `rails generate hyrax:work Folio`
module Hyrax
  # Generated form for Folio
  class FolioForm < Hyrax::Forms::WorkForm
    self.model_class = ::Folio
    self.terms += [:abstract]
    self.terms += [:resource_type]

    # 13-12-2018 JL:
    self.terms += [:genre]
    self.terms += [:bibliography]
    self.terms += [:dris_page_no]
    self.terms += [:dris_document_no]
    self.terms += [:dris_unique]
    self.terms += [:format_duration]
    self.terms += [:copyright_status]
    self.terms += [:copyright_note]
    self.terms += [:digital_root_number]
    self.terms += [:digital_object_identifier]
    #self.terms += [:language_code]
    self.terms += [:location_type]
    self.terms += [:shelf_locator]
    # self.terms += [:role]
    # self.terms += [:role_code]
    self.terms += [:sponsor]
    self.terms += [:conservation_history]
    self.terms += [:publisher_location]
    self.terms += [:page_number]
    self.terms += [:page_type]
    self.terms += [:physical_extent]
    self.terms += [:support]
    self.terms += [:medium]
    #self.terms += [:type_of_work]

    #self.terms += [:subject_lcsh]
    #self.terms += [:subject_local]
    #self.terms += [:subject_name]
    self.terms += [:alternative_title]
    self.terms += [:series_title]
    self.terms += [:collection_title]

    self.terms += [:provenance]

    self.terms += [:culture]
    self.terms += [:county]
    self.terms += [:folder_number]
    self.terms += [:project_number]
    self.terms += [:order_no]
    self.terms += [:total_records]
    self.terms += [:location]


  end
end

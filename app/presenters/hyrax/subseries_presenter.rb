# Generated via
#  `rails generate hyrax:work Subseries`
module Hyrax
  class SubseriesPresenter < Hyrax::WorkShowPresenter

    # JL : 07/12/2018
    delegate :abstract, to: :solr_document
    delegate :genre, to: :solr_document
    # JL: 2020-04-27 suppress Page No
    #delegate :dris_page_no, to: :solr_document

    delegate :copyright_note, to: :solr_document
    delegate :copyright_status, to: :solr_document

    delegate :digital_object_identifier, to: :solr_document
    delegate :dris_unique, to: :solr_document
    # delegate :language_code, to: :solr_document
    # delegate :role, to: :solr_document
    delegate :sponsor, to: :solr_document
    delegate :publisher_location, to: :solr_document
    delegate :support, to: :solr_document
    delegate :medium, to: :solr_document
    #delegate :type_of_work, to: :solr_document
    #delegate :subject_lcsh, to: :solr_document
    #delegate :subject_local, to: :solr_document
    #delegate :subject_name, to: :solr_document
    delegate :alternative_title, to: :solr_document
    delegate :series_title, to: :solr_document
    delegate :collection_title, to: :solr_document

    delegate :provenance, to: :solr_document
    delegate :culture, to: :solr_document
    delegate :location, to: :solr_document
    delegate :folder_number, to: :solr_document
    delegate :doi, to: :solr_document
    delegate :biographical_note, to: :solr_document
    delegate :finding_aid, to: :solr_document
    delegate :note, to: :solr_document
    delegate :sub_fond, to: :solr_document
    delegate :arrangement, to: :solr_document
    delegate :issued_with, to: :solr_document
    delegate :bibliography, to: :solr_document
    delegate :physical_extent, to: :solr_document

  end
end

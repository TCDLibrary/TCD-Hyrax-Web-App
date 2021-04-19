# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document
  include Blacklight::Gallery::OpenseadragonSolrDocument

  # Adds Hyrax behaviors to the SolrDocument.
  include Hyrax::SolrDocumentBehavior


  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

  # Do content negotiation for AF models.

  use_extension( Hydra::ContentNegotiation )

  # JL: 07/12/2018
  def abstract
    self[Solrizer.solr_name('abstract')]
  end

  def genre
    self[Solrizer.solr_name('genre')]
  end

  def dris_page_no
    self[Solrizer.solr_name('dris_page_no')]
  end

  def copyright_status
    self[Solrizer.solr_name('copyright_status')]
  end

  def digital_object_identifier
    self[Solrizer.solr_name('digital_object_identifier')]
  end

  def dris_unique
    self[Solrizer.solr_name('dris_unique')]
  end

  #def language_code
  #  self[Solrizer.solr_name('language_code')]
  #end

  # def role
  #   self[Solrizer.solr_name('role')]
  # end

  def sponsor
    self[Solrizer.solr_name('sponsor')]
  end

  def publisher_location
    self[Solrizer.solr_name('publisher_location')]
  end

  def support
    self[Solrizer.solr_name('support')]
  end

  def medium
    self[Solrizer.solr_name('medium')]
  end

  #def type_of_work
  #  self[Solrizer.solr_name('type_of_work')]
  #end

  #def subject_lcsh
  #  self[Solrizer.solr_name('subject_lcsh')]
  #end

  #def subject_local
  #  self[Solrizer.solr_name('subject_local')]
  #end

  #def subject_name
  #  self[Solrizer.solr_name('subject_name')]
  #end

  def alternative_title
    self[Solrizer.solr_name('alternative_title')]
  end

  def series_title
    self[Solrizer.solr_name('series_title')]
  end

  def collection_title
    self[Solrizer.solr_name('collection_title')]
  end

  def provenance
    self[Solrizer.solr_name('provenance')]
  end

  def folder_number
    self[Solrizer.solr_name('folder_number')]
  end

  def camera_model
    self[Solrizer.solr_name('camera_model')]
  end

  def camera_make
    self[Solrizer.solr_name('camera_make')]
  end

  def date_taken
    self[Solrizer.solr_name('date_taken')]
  end

  def exposure_time
    self[Solrizer.solr_name('exposure_time')]
  end

  def f_number
    self[Solrizer.solr_name('f_number')]
  end

  def iso_speed_rating
    self[Solrizer.solr_name('iso_speed_rating')]
  end

  def flash
    self[Solrizer.solr_name('flash')]
  end

  def exposure_program
    self[Solrizer.solr_name('exposure_program')]
  end

  def focal_length
    self[Solrizer.solr_name('focal_length')]
  end

  def software
    self[Solrizer.solr_name('software')]
  end

  def culture
    self[Solrizer.solr_name('culture')]
  end

  def location
    self[Solrizer.solr_name('location')]
  end

  def fedora_sha1
    self[Solrizer.solr_name('fedora_sha1')]
  end

  def doi
    self[Solrizer.solr_name('doi')]
  end

end

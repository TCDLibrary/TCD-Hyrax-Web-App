# Generated via
#  `rails generate hyrax:work Work`
class Work < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = WorkIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  # 20-11-2018 JL:
  property :genre, predicate: ::RDF::Vocab::MODS.genre do |index|
    index.as :stored_searchable, :facetable
  end
  property :bibliography, predicate: ::RDF::Vocab::MODS.note do |index|
    index.as :stored_searchable, :facetable
  end
  property :dris_page_no, predicate: ::RDF::Vocab::MODS.partOrder
  property :dris_document_no, predicate: ::RDF::Vocab::DC.identifier

  property :page_no, predicate: ::RDF::Vocab::MODS.partType
  #todo: needs a unique RDF cross ref
  #property :page_type, predicate: ::RDF::Vocab::MODS.partOrder

  property :catalog_no, predicate: ::RDF::Vocab::MODS.recordIdentifier do |index|
    index.as :stored_searchable, :facetable
  end

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end

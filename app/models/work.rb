# Generated via
#  `rails generate hyrax:work Work`
class Work < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = WorkIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  # 20-11-2018 JL:

  property :dris_page_no, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#dp')
  property :dris_document_no, predicate: ::RDF::Vocab::DC.identifier
  property :format_duration, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#fd')
  property :format_resolution, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#fr')

  #  29/11/2018: JL - abstract already exists
  #  property :abstract, predicate: ::RDF::Vocab::MODS.abstract

  #  29/11/2018: JL - access condition in Michelle's xls (Expired, Active, etc) is not in her Mods File
  #  JL: copyright status is in BasicMetadata
  property :copyright_holder, predicate: ::RDF::Vocab::DC.rightsHolder

  # this is TGM genre:
  property :genre, predicate: ::RDF::URI.new("http://id.loc.gov/vocabulary/graphicMaterials") do |index|
    index.as :stored_searchable, :facetable
  end

  property :digital_root_number, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#id')
  property :digital_object_identifier, predicate: ::RDF::Vocab::MODS.identifier
  property :dris_unique, predicate: ::RDF::Vocab::MODS.recordIdentifier do |index|
    index.as :stored_searchable, :facetable
  end

  property :language_code, predicate: ::RDF::URI.new('https://www.loc.gov/standards/iso639-2')
  #  JL: language is in BasicMetadata DC11.language

  #  JL: location already exists
  property :location_type, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#lt')
  property :shelf_locator, predicate: ::RDF::Vocab::MODS.locationShelfLocator

  #  JL: contributor alrady exists in BasicMetadata
  # property :contributor, predicate: ::RDF::URI.new('http://id.loc.gov/authorities/names')

  #  JL: Michelle wanted both of these role fiels to link to <name><role><roleTerm>
  property :role_code, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#rc')
  property :role, predicate: ::RDF::URI.new('https://www.loc.gov/standards/sourcelist/relator-role')

  #  JL: how to handle locally created contributor names, role_code and role? Same data as above but different Mods to be output

  property :sponsor, predicate: ::RDF::URI.new('http://www.loc.gov/marc/bibliographic/bd536')

  property :bibliography, predicate: ::RDF::URI.new("https://www.loc.gov/marc/bibliographic/bd504") do |index|
    index.as :stored_searchable, :facetable
  end

  property :conservation_history, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#ch')

  #  JL: date is in BasicMetadata
  #  JL: publsher is in BasicMetadata

  #  JL publisher place and publisher country are both described for MODS.place so merged
  property :publisher_location, predicate: ::RDF::Vocab::MODS.placeOfOrigin

  property :page_number, predicate: ::RDF::Vocab::MODS.partOrder
  property :page_type, predicate: ::RDF::Vocab::MODS.partType

  property :physical_extent, predicate: ::RDF::Vocab::MODS.physicalExtent
  #  JL: can physical_entent replace format_h and format_w?
  #  property :format_h, predicate: ::RDF::Vocab::????
  #  property :format_w, predicate: ::RDF::Vocab::????

  #  property :total_records, predicate: ::RDF::Vocab::????                 <<<< JL: is this really metadata?
  #  property :order_no, predicate: ::RDF::Vocab::????                      <<<< MA: not used in FileMaker
  #  property :county, predicate: ::RDF::Vocab::????                        <<<< MA: not used in FileMaker
  #  property :folder_number, predicate: ::RDF::Vocab::????                 <<<< JL: is this really metadata?
  #  property :project_number, predicate: ::RDF::Vocab::????                <<<< JL: is this really metadata?

  #  JL: note, in FileMaker can be captured in two places, depending on whether vocab used
  #  JL: note, see also BasicMetadata
  #  property :role_code, predicate: ::RDF::Vocab::????
  #  property :role, predicate: ::RDF::Vocab::????

  #  JL: item_title is in CoreMetadata

  #  property :alternative_title, predicate: ::RDF::Vocab::????
  #  property :series_title, predicate: ::RDF::Vocab::????
  #  property :collection_title, predicate: ::RDF::Vocab::????              <<<< JL: why store? Can we not derive? What if it is in multiple collections?
  #  property :virtual_collection_title, predicate: ::RDF::Vocab::????      <<<< JL: how is this different to collection_title

  #  property :related_item_type, predicate: ::RDF::Vocab::????
  #  property :related_item_identifier, predicate: ::RDF::Vocab::????
  #  property :related_item_title, predicate: ::RDF::Vocab::????


  #  JL is copyright_notes in BasicMetadata?

  #  property :copyright_notice, predicate: ::RDF::Vocab::????


  #  JL: BasicMetadata? property :type, predicate: ::RDF::Vocab::????

  #  property: type_of_work/genre_of_work , predicate: ::RDF::Vocab::????   <<<< JL: What to call it?

  #  property :culture, predicate: ::RDF::Vocab::????                       <<<< MA: no Mods equivalent




  #  property :support, predicate: ::RDF::Vocab::????
  #  property :medium, predicate: ::RDF::Vocab::????

  #  JL: metadata_modification_date is in CoreMetadata

  #  property :solr, predicate: ::RDF::Vocab::????                          <<<< JL: this is not metadata
  #  property :visibility, predicate: ::RDF::Vocab::????                    <<<< JL: this is not metadata, it is for managing catalogers workflow
  #  property :europeana, predicate: ::RDF::Vocab::????                     <<<< JL: this is not metadata, it is for managing catalogers workflow
  #  property :sponsor, predicate: ::RDF::Vocab::????
  #  property :provenance, predicate: ::RDF::Vocab::????

  #  JL: subject is in BasicMetadata
  #  JL: subject_names is in BasicMetadata

  #  property :local_keyword/open_keyword, predicate: ::RDF::Vocab::????

  #  JL: caption/notes/description is in BasicMetadata

  #  property :abstract, predicate: ::RDF::Vocab::MODS.abstract



  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end

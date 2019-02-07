module TcdExtendedMetadata
  extend ActiveSupport::Concern

  included do
      # TODO : review this list.
      # TODO : Check all fields present
      # TODO : Check predicates, e.g. DC.identifier and Mods.Identifier being used
      # TODO : Review the two letter internal predicate codes. Make more descriptive?
      # TODO : Are fields marked searchable working ok?
      # TODO : Are fields marked facetable working ok?

      property :dris_page_no, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#dp') do |index|
        index.as :stored_searchable
      end

      property :dris_document_no, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#dris_document_no')
      property :format_duration, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#fd')
      property :format_resolution, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#fr')

      property :abstract, predicate: ::RDF::Vocab::MODS.abstract do |index|
        index.type :text
        index.as :stored_searchable
      end

      #  29/11/2018: JL - access condition in Michelle's xls (Expired, Active, etc) is not in her Mods File
      #  JL: copyright status is in BasicMetadata

      property :copyright_status, predicate: ::RDF::Vocab::DC.rightsHolder do |index|
        index.as :stored_searchable
      end

      property :copyright_note, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#copyright_note')


      property :genre, predicate: ::RDF::URI.new("http://id.loc.gov/vocabulary/graphicMaterials") do |index|
        index.as :stored_searchable, :facetable
      end

      property :digital_root_number, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#id')

      property :digital_object_identifier, predicate: ::RDF::Vocab::MODS.identifier do |index|
        index.as :stored_searchable
      end

      property :dris_unique, predicate: ::RDF::Vocab::MODS.recordIdentifier do |index|
        index.as :stored_searchable, :facetable
      end

      #property :language_code, predicate: ::RDF::URI.new('https://www.loc.gov/standards/iso639-2') do |index|
      #  index.as :stored_searchable
      #end
      #  JL: language is in BasicMetadata DC11.language

      #  JL: location already exists
      property :location_type, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#lt')
      property :shelf_locator, predicate: ::RDF::Vocab::MODS.locationShelfLocator

      #  JL: contributor alrady exists in BasicMetadata
      # property :contributor, predicate: ::RDF::URI.new('http://id.loc.gov/authorities/names')

      #  JL: Michelle wanted both of these role fields to link to <name><role><roleTerm>
      # property :role_code, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#rc')

      # property :role, predicate: ::RDF::URI.new('https://www.loc.gov/standards/sourcelist/relator-role') do |index|
      #   index.as :stored_searchable
      # end

      #  JL: how to handle locally created contributor names, role_code and role? Same data as above but different Mods to be output

      property :sponsor, predicate: ::RDF::URI.new('http://www.loc.gov/marc/bibliographic/bd536') do |index|
        index.as :stored_searchable
      end

      property :bibliography, predicate: ::RDF::URI.new("https://www.loc.gov/marc/bibliographic/bd504") do |index|
        index.as :stored_searchable, :facetable
      end

      property :conservation_history, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#ch')

      #  JL: date is in BasicMetadata
      #  JL: publsher is in BasicMetadata

      #  JL publisher place and publisher country are both described for MODS.place so merged

      property :publisher_location, predicate: ::RDF::Vocab::MODS.placeOfOrigin do |index|
        index.as :stored_searchable
      end

      property :page_number, predicate: ::RDF::Vocab::MODS.partOrder
      property :page_type, predicate: ::RDF::Vocab::MODS.partType

      property :physical_extent, predicate: ::RDF::Vocab::MODS.physicalExtent
      #  JL: can physical_entent replace format_h and format_w?
      #  property :format_h, predicate: ::RDF::Vocab::????
      #  property :format_w, predicate: ::RDF::Vocab::????

      property :support, predicate: ::RDF::Vocab::MODS.physicalForm do |index|
        index.as :stored_searchable
      end

      #  JL: medium cant refer to same Mods field as support
      property :medium, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#me') do |index|
        index.as :stored_searchable
      end

      #property :type_of_work, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#type_of_work') do |index|
      #  index.as :stored_searchable
      #end

      #  JL: modification_date is in CoreMetadata
      #  JL: creation_date is in CoreMetadata

      property :related_item_type, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#related_item_type')
      property :related_item_identifier, predicate: ::RDF::Vocab::MODS.relatedItem
      property :related_item_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#related_item_title')

      #property :subject_lcsh, predicate: ::RDF::Vocab::MODS.subject do |index|
      #  index.as :stored_searchable
      #end

      #property :subject_local, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#subject_local') do |index|
      #  index.as :stored_searchable
      #end

      #  JL: subject is in BasicMetadata

      #property :subject_name, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#subject_name') do |index|
      #  index.as :stored_searchable
      #end

      #  JL: caption/notes/description is in BasicMetadata

      property :alternative_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#alternative_title') do |index|
        index.as :stored_searchable
      end

      #  JL: item_title is in CoreMetadata

      property :series_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#series_title') do |index|
        index.as :stored_searchable
      end

      property :collection_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#collection_title') do |index|
        index.as :stored_searchable
      end

      property :virtual_collection_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#virtual_collection_title') do |index|
        index.as :stored_searchable
      end

      #  JL: type_of_resource is in BasicMetadata

      property :provenance, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#provenance') do |index|
        index.as :stored_searchable
      end

      #  JL:property :copyright_notice, see rights in BasicMetadata, DC.rights

      property :visibility_flag, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#visibility')
      property :europeana, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#europeana')
      property :solr_flag, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#solr')

      property :culture, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#culture') do |index|
        index.as :stored_searchable
      end

      property :county, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#county')
      property :folder_number, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#folder_number')
      property :project_number, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#project_number')
      property :order_no, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#order_no')
      property :total_records, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#total_records')

      #  JL: note, in FileMaker can be captured in two places, depending on whether vocab used
      # TODO : test if searchable
      property :location, predicate: ::RDF::Vocab::MODS.Location  do |index|
        index.as :stored_searchable
      end


  end

end

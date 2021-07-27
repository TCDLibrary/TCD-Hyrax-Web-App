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

      property :abstract, predicate: ::RDF::Vocab::MODS.abstract do |index|
        index.type :text
        index.as :stored_searchable
      end

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


      property :medium, predicate: ::RDF::Vocab::DC.format do |index|
        index.as :stored_searchable
      end

      property :alternative_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#alternative_title') do |index|
        index.as :stored_searchable
      end

      property :series_title, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#series_title') do |index|
        index.as :stored_searchable
      end

      property :collection_title, predicate: ::RDF::Vocab::MODS.relatedItem do |index|
        index.as :stored_searchable
      end

      property :provenance, predicate: ::RDF::Vocab::DC.provenance do |index|
        index.as :stored_searchable
      end

      property :culture, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#culture') do |index|
        index.as :stored_searchable
      end

      property :county, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#county')
      property :folder_number, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#folder_number') do |index|
        index.as :stored_searchable
      end

      property :project_number, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#project_number')
      property :order_no, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#order_no')
      property :total_records, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#total_records')

      #  JL: note, in FileMaker can be captured in two places, depending on whether vocab used
      # TODO : test if searchable
      property :location, predicate: ::RDF::Vocab::MODS.Location  do |index|
        index.as :stored_searchable, :facetable
      end

      # 29/03/2019 JL - split creator, genre and subject for Michelle
      property :creator_loc, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#creator_loc')
      property :creator_local, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#creator_local')
      property :genre_aat, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#genre_aat')
      property :genre_tgm, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#genre_tgm')
      property :subject_lcsh, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#subject_lcsh')
      property :subject_subj_name, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#subject_subj_name')
      property :subject_local_keyword, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#subject_local_keyword')
      # 29/03/2019 JL - experimental belongs_to added to work objects
      property :i_belong_to, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#i_belong_to')

      property :doi, predicate: ::RDF::URI.new('http://id.loc.gov/vocabulary/identifiers/doi'), multiple: false do |index|
        index.as :stored_searchable
      end

      property :biographical_note, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#biographical_note') do |index|
        index.as :stored_searchable
      end

      property :finding_aid, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#finding_aid') do |index|
        index.as :stored_searchable
      end
      property :note, predicate: ::RDF::Vocab::MODS.NoteGroup do |index|
        index.as :stored_searchable
      end
      property :sub_fond, predicate: ::RDF::URI.new('https://digitalcollections.tcd.ie/app/assets/local_vocabulary.html#sub_fond') do |index|
        index.as :stored_searchable
      end

  end

end

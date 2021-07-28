# frozen_string_literal: true
require 'tcd_metadata/marc_xml_record'
require 'nokogiri'
module Bulkrax
  # Generic XML Entry
  class MarcXmlEntry < Entry
    serialize :raw_metadata, JSON

    def self.fields_from_data(data); end


    # @param [String] path
    # @return [Nokogiri::XML::Document]
    def self.read_data(path)
      Nokogiri::XML(open(path)).remove_namespaces!
    end


    # @param [Nokogiri::XML::Element] data
    def self.data_for_entry(data)
      collections = []
      children = []
      xpath_for_source_id = ".//*[name()='#{source_identifier_field}']"
      return {
        source_identifier: data.xpath(xpath_for_source_id).first.text,
        data:
          data.document.to_xml(
            encoding: 'utf-8',
            save_with:
                Nokogiri::XML::Node::SaveOptions::DEFAULT_XML | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS
          ).delete("\n").delete("\t").tr("\u0091", '‘').tr("\u0092", '’').tr("\u0096", ' '),
        collection: collections,
        children: children
      }
    end

    def source_identifier
      @source_identifier ||= self.raw_metadata['source_identifier']
    end

    def record
    # JL: self.raw_metadata['data'] is the full XML file. So MarcXmlRecord has to pull just the current recordIdentifier node
      @record ||= TcdMetadata::MarcXmlRecord.new(source_identifier, self.raw_metadata['data'])
    end

    def files
      @files ||= record.files
    end

    def build_metadata
      raise StandardError, 'Record not found' if record.nil?
      raise StandardError, 'Missing source identifier' if source_identifier.blank?
      self.parsed_metadata = {}
      self.parsed_metadata['admin_set_id'] = self.importerexporter.admin_set_id
      self.parsed_metadata[Bulkrax.system_identifier_field] = [source_identifier]

      record.attributes.each do |k,v|
        add_metadata(k, v) unless v.blank?
      end
      add_title
      add_visibility
      add_rights_statement
      add_genres
      add_abstracts
      add_identifiers # => shelf mark
      add_locations
      add_creators
      add_contributors
      add_publisher_locations
      add_publishers
      add_dates_created
      add_languages
      add_related_urls
      add_sponsors
      add_subjects_and_keywords
      add_resource_types
      add_mediums
      add_supports
      add_digital_object_identifier
      add_folder_number
      add_digital_root_number
      add_image_range
      add_dris_unique
      add_project_number
      add_biographical_notes
      add_finding_aids
      add_alternative_titles
      add_physical_extents
      add_series_titles
      add_provenances
      add_bibliographys
      add_notes
      add_collection_titles
      add_sub_fonds
      add_local
      if parent_collection?
         add_collections
      end
      raise StandardError, "title is required" if record.title.blank?
      self.parsed_metadata
    end

    def add_title
      self.parsed_metadata['title'] = [record.title.chomp("/")]
    end

    def add_genres
      #byebug
      #genres = self.parsed_metadata['genre'] = [record.genres]
      #genres = [record.genres.text]
      self.parsed_metadata['genre'] = []
      self.parsed_metadata['genre_aat'] = []
      self.parsed_metadata['genre_tgm'] = []
      record.genres.each do | gen |
        #byebug
        code_a = gen.xpath("subfield[@code='a']").text.strip
        code_2 = gen.xpath("subfield[@code='2']").text.strip
        self.parsed_metadata['genre'] << (code_a + " : " + code_2).strip
        if code_2.eql?  'aat'
          self.parsed_metadata['genre_aat'] << (code_a + " : " + code_2).strip
        else if code_2.eql? 'lctgm'
               self.parsed_metadata['genre_tgm'] << (code_a + " : " + code_2).strip
             end
        end
      end
    end

    def add_abstracts
      self.parsed_metadata['abstract'] = [record.abstracts.text.strip]
      desc = record.abstracts.text.strip
      if desc.length > 200
        desc = (desc.slice(0..200) + '...')
      end
      self.parsed_metadata['description'] = [desc]
    end

    def add_identifiers # => shelf mark
      self.parsed_metadata['identifier'] = []
      record.identifiers.each do | id |
        self.parsed_metadata['identifier'] << id.text.strip
      end
    end

    def add_locations
      self.parsed_metadata['location'] = []
      record.locations.each do | loc |
        self.parsed_metadata['location'] << loc.text.strip
      end
    end

    def add_creators
      self.parsed_metadata['creator'] = []
      self.parsed_metadata['creator_loc'] = []
      self.parsed_metadata['creator_local'] = []
      record.creators.each do | cre |
        code_a = cre.xpath("subfield[@code='a']").text.strip  # surname
        code_b = cre.xpath("subfield[@code='b']").text.strip  #
        code_c = cre.xpath("subfield[@code='c']").text.strip  # persons title
        code_d = cre.xpath("subfield[@code='d']").text.strip  # years
        code_e = cre.xpath("subfield[@code='e']").text.strip.chomp(".").capitalize  # role. chomp off the trailing full stop
        code_j = cre.xpath("subfield[@code='j']").text.strip  #
        code_n = cre.xpath("subfield[@code='n']").text.strip  #
        code_q = cre.xpath("subfield[@code='q']").text.strip  # first names
        code_5 = cre.xpath("subfield[@code='5']").text.strip  # JL : to do : whats this?
        code_2 = cre.xpath("subfield[@code='2']").text.strip  # means role code is local
        a_creator = ""
        if (cre.values[0].eql? "100") || (cre.values[0].eql? "700")
          a_creator = (code_a + ' ' + code_q + ' ' + code_b + ' ' + code_c + ' ' + code_d + ' ' + code_e).strip
        else if (cre.values[0].eql? "111") || (cre.values[0].eql? "711")
            #$a $n $d $c $e $j
            a_creator = (code_a + ' ' + code_n + ' ' + code_d + ' ' + code_c + ' ' + code_e + ' ' + code_j).strip
               else # 110 or 710
                 a_creator = (code_a + ' ' + code_b + ' ' + code_e).strip
          end
        end
        #byebug
        if code_e && Role_codes_creator.value?(code_e) && code_2.empty? # reverse lookup of Role_codes_creator
          self.parsed_metadata['creator'] << a_creator.gsub(/ +/, " ")
          # role code might be local:
          if !code_2.empty?
            self.parsed_metadata['creator_local'] << a_creator.gsub(/ +/, " ")
          else
            self.parsed_metadata['creator_loc'] << a_creator.gsub(/ +/, " ")
          end
        end

      end # each
    end # def

    def add_contributors
      self.parsed_metadata['contributor'] = []
      record.creators.each do | con |
        code_a = con.xpath("subfield[@code='a']").text.strip  # surname
        code_b = con.xpath("subfield[@code='b']").text.strip  #
        code_c = con.xpath("subfield[@code='c']").text.strip  # persons title
        code_d = con.xpath("subfield[@code='d']").text.strip  # years
        code_e = con.xpath("subfield[@code='e']").text.strip.chomp(".").capitalize  # role. chomp off the trailing full stop
        code_j = con.xpath("subfield[@code='j']").text.strip  #
        code_n = con.xpath("subfield[@code='n']").text.strip  #
        code_q = con.xpath("subfield[@code='q']").text.strip  # first names
        code_5 = con.xpath("subfield[@code='5']").text.strip  # JL : to do : whats this?
        code_2 = con.xpath("subfield[@code='2']").text.strip  # means role code is local
        # a_contributor = code_a + ' ' + code_q + ' ' + code_d + ' ' + code_e
        a_contributor = ""
        if (con.values[0].eql? "100") || (con.values[0].eql? "700")
          a_contributor = (code_a + ' ' + code_q + ' ' + code_b + ' ' + code_c + ' ' + code_d + ' ' + code_e).strip
        else if (con.values[0].eql? "111") || (con.values[0].eql? "711")
            #$a $n $d $c $e $j
            a_contributor = (code_a + ' ' + code_n + ' ' + code_d + ' ' + code_c + ' ' + code_e + ' ' + code_j).strip
               else # 110 or 710
                  a_contributor = (code_a + ' ' + code_b + ' ' + code_e).strip
               end
        end
        #byebug
        if code_e && Role_codes_contributor.value?(code_e) && code_2.empty? # reverse lookup of Role_codes_creator
          self.parsed_metadata['contributor'] << a_contributor.gsub(/ +/, " ")
        end
      end # each
    end # def

    def add_publisher_locations
      self.parsed_metadata['publisher_location'] = []
      record.publisher_locations.each  do | loc |
        self.parsed_metadata['publisher_location'] << loc.text.strip
      end
    end

    def add_publishers
      self.parsed_metadata['publisher'] = []
      record.publishers.each  do | pub |
        self.parsed_metadata['publisher'] << pub.text.strip
      end
    end

    def add_dates_created
      self.parsed_metadata['date_created'] = []
      record.dates_created.each  do | cr_dat |
        self.parsed_metadata['date_created'] << cr_dat.text.strip
      end
    end

    def add_languages
      self.parsed_metadata['language'] = []
      record.languages.each  do | lang |
        self.parsed_metadata['language'] << lang.text.strip
      end
    end

    def add_related_urls
      self.parsed_metadata['related_url'] = []
      record.related_urls.each  do | url |
        self.parsed_metadata['related_url'] << url.text.strip
      end
    end

    def add_sponsors
      self.parsed_metadata['sponsor'] = []
      record.sponsors.each do | spon |
        self.parsed_metadata['sponsor'] << spon.text.strip
      end
    end

    def add_subjects_and_keywords
      self.parsed_metadata['subject'] = []
      self.parsed_metadata['keyword'] = []
      record.subjects_and_keywords.each do | subj |
        code_a = subj.xpath("subfield[@code='a']").text.strip  # surname
        code_b = subj.xpath("subfield[@code='b']").text.strip
        code_c = subj.xpath("subfield[@code='c']").text.strip  # persons title
        code_d = subj.xpath("subfield[@code='d']").text.strip  # years
        code_e = subj.xpath("subfield[@code='e']").text.strip
        code_g = subj.xpath("subfield[@code='g']").text.strip
        code_j = subj.xpath("subfield[@code='j']").text.strip
        code_l = subj.xpath("subfield[@code='l']").text.strip
        code_n = subj.xpath("subfield[@code='n']").text.strip
        code_q = subj.xpath("subfield[@code='q']").text.strip  # first names
        code_t = subj.xpath("subfield[@code='t']").text.strip
        code_v = subj.xpath("subfield[@code='v']").text.strip
        code_x = subj.xpath("subfield[@code='x']").text.strip
        code_y = subj.xpath("subfield[@code='y']").text.strip
        code_z = subj.xpath("subfield[@code='z']").text.strip
        code_2 = subj.xpath("subfield[@code='2']").text.strip  # check if role code is local

        case subj.values[0]
        when '600'
           # 600 subfield order: $a $b $c $q $d $l $t $x $z $y $v $e $2
           a_keyword = (code_a + ' ' + code_b  + ' ' + code_c + ' ' + code_q + ' ' + code_d+ ' ' + code_l  + ' ' + code_t + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v + ' ' + code_e).strip
        when '610'
           # 610 subfield order: $a $b $c $d $l $t $x $z $y $v $e $2
           a_keyword = (code_a + ' ' + code_b  + ' ' + code_c + ' ' + code_d + ' ' + code_l  + ' ' + code_t + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v + ' ' + code_e).strip
        when '611'
           # 611 subfield order: $a $n $d $c $e $l $t $x $z $y $v $j $2
           a_keyword = (code_a + ' ' + code_n  + ' ' + code_d + ' ' + code_c + ' ' + code_e + ' ' + code_l  + ' ' + code_t + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v + ' ' + code_j).strip
        when '647'
           # 647 subfield order: $a $c $d $g $x $z $y $v $2
           a_keyword = (code_a + ' ' + code_c  + ' ' + code_d + ' ' + code_g + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v).strip
        when '648'
           # 648 subfield order: $a $x $z $y $v $2
           a_keyword = (code_a + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v).strip
        when '650'
           # 650 subfield order: $a $b $c $d $x $z $y $v $e $2
           a_keyword = (code_a + ' ' + code_b  + ' ' + code_c + ' ' + code_d + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v + ' ' + code_e).strip
        else
           # 651 subfield order: $a $x $z $y $v $e $2
           a_keyword = (code_a + ' ' + code_x + ' ' + code_z  + ' ' + code_y + ' ' + code_v + ' ' + code_e).strip
        end

        if code_2.eql? 'local'
          #a_keyword = (code_a + ' ' + code_c + ' ' + code_q + ' ' + code_d).strip
          self.parsed_metadata['keyword'] << a_keyword.gsub(/ +/, " ")
        else
          #a_subject = (code_a + ' ' + code_c + ' ' + code_q + ' ' + code_d).strip
          self.parsed_metadata['subject'] << a_keyword.gsub(/ +/, " ")
        end
      end
    end

    def add_resource_types
      self.parsed_metadata['resource_type'] = []
      record.resource_types.each do | rtyp |
        self.parsed_metadata['resource_type'] << rtyp.text.strip
      end
    end

    def add_mediums
      self.parsed_metadata['medium'] = []
      record.mediums.each do | med |
        self.parsed_metadata['medium'] << med.text.strip
      end
    end

    def add_supports
      self.parsed_metadata['support'] = []
      record.supports.each do | sup |
        self.parsed_metadata['support'] << sup.text.strip
      end
    end

    def add_digital_object_identifier
      self.parsed_metadata['digital_object_identifier'] = [record.digital_object_identifier]
    end

    def add_folder_number
      self.parsed_metadata['folder_number'] = [record.folder_number]
    end

    def add_digital_root_number
      self.parsed_metadata['digital_root_number'] = [record.digital_root_number]
    end

    def add_image_range
      self.parsed_metadata['image_range'] = [record.image_range]
    end

    def add_dris_unique
      self.parsed_metadata['dris_unique'] = [record.dris_unique]
    end

    def add_project_number
      self.parsed_metadata['project_number'] = [record.project_number]
    end

    def add_biographical_notes
      self.parsed_metadata['biographical_note'] = []
      record.biographical_notes.each  do | bio |
        self.parsed_metadata['biographical_note'] << bio.text.strip
      end
    end

    def add_finding_aids
      self.parsed_metadata['finding_aid'] = []
      record.finding_aids.each  do | aid |
        self.parsed_metadata['finding_aid'] << aid.text.strip
      end
    end

    def add_alternative_titles
      self.parsed_metadata['alternative_title'] = []
      record.alternative_titles.each do | alt |
        code_a = alt.xpath("subfield[@code='a']").text.strip  # Title proper/short title
        code_b = alt.xpath("subfield[@code='b']").text.strip  # Remainder of title
        code_n = alt.xpath("subfield[@code='n']").text.strip  # Number of part/section of a work
        code_p = alt.xpath("subfield[@code='p']").text.strip  # Name of part/section of a work
        alt_title = (code_a + code_b + code_n + code_p).strip
        self.parsed_metadata['alternative_title'] << alt_title.gsub(/ +/, " ")
      end
    end

    def add_physical_extents
      self.parsed_metadata['physical_extent'] = []
      record.physical_extents.each do | ext |
        code_a = ext.xpath("subfield[@code='a']").text.strip  # Extent
        code_c = ext.xpath("subfield[@code='c']").text.strip  # Dimensions
        code_e = ext.xpath("subfield[@code='e']").text.strip  # Accompanying material
        an_extent = (code_a + ' ' + code_c + ' ' + code_e).strip
        self.parsed_metadata['physical_extent'] << an_extent.gsub(/ +/, " ")
      end
    end

    def add_series_titles
      self.parsed_metadata['series_title'] = []
      record.series_titles.each do | stit |
        code_a = stit.xpath("subfield[@code='a']").text.strip  # Series statement
        code_x = stit.xpath("subfield[@code='x']").text.strip  # International Standard Serial Number
        code_v = stit.xpath("subfield[@code='v']").text.strip  # Volume/sequential designation
        a_title = (code_a + ' ' + code_x + ' ' + code_v).strip
        self.parsed_metadata['series_title'] << a_title.gsub(/ +/, " ")
      end
    end

    def add_provenances
      self.parsed_metadata['provenance'] = []
      record.provenances.each do | prov |
        code_a = prov.xpath("subfield[@code='a']").text.strip  # History
        code_u = prov.xpath("subfield[@code='u']").text.strip  # Uniform Resource Identifier
        a_prov = (code_a + ' ' + code_u).strip
        self.parsed_metadata['provenance'] << a_prov.gsub(/ +/, " ")
      end
    end

    def add_bibliographys
      self.parsed_metadata['bibliography'] = []
      record.bibliographys.each  do | bib |
        self.parsed_metadata['bibliography'] << bib.text.strip
      end
    end

    def add_notes
      self.parsed_metadata['note'] = []
      record.notes.each do | note |
        self.parsed_metadata['note'] << note.text.strip
      end
    end

    def add_collection_titles
      self.parsed_metadata['collection_title'] = []
      record.collection_titles.each do | colt |
        code_a = colt.xpath("subfield[@code='a']").text.strip
        code_n = colt.xpath("subfield[@code='n']").text.strip

        if code_n.eql? 'Collection'
          self.parsed_metadata['collection_title'] << code_a
        end
      end
    end


    def add_sub_fonds
      self.parsed_metadata['sub_fond'] = []
      record.sub_fonds.each do | fond |
        code_a = fond.xpath("subfield[@code='a']").text.strip
        code_n = fond.xpath("subfield[@code='n']").text.strip

        if (code_n.eql? 'Sub-Series') || (code_n.eql? 'Sub-sub-series')
          self.parsed_metadata['sub_fond'] << code_a
        end
      end
    end

    def collections_created?
      return true if importerexporter.parser_fields['parent_id'].blank?
      return true unless find_or_create_collection_ids.blank?
    end

    def find_or_create_collection_ids
      self.collection_ids = [parent.id] if parent?
      collection_ids
    rescue StandardError
      []
    end

    def parent?
      !parent.blank?
    end

    def parent
      @parent ||= ActiveFedora::Base.find(importerexporter.parser_fields['parent_id'])
    rescue StandardError
      nil
    end

    def parent_attributes
      @parent_attributes ||= parent.attributes if parent?
    end

    def parent_collection?
      parent.is_a?(Collection)
    end

    def factory_class
      importerexporter.parser_fields['object_type'].constantize
    end

  end
end

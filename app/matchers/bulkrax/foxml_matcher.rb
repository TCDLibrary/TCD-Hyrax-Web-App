module Bulkrax
  class FoxmlMatcher < Bulkrax::ApplicationMatcher
    def parse_creator_loc(src)
      src.strip
    end

    def parse_creator_local(src)
      src.strip
    end

    def parse_language(src)
      src.strip
    end

    def parse_location(src)
      src.strip
    end

    def parse_copyright_status(src)
      src.strip
    end

    def parse_copyright_note(src)
      src.strip
    end

    def parse_location_type(src)
      src.strip
    end

    def parse_support(src)
      src.strip
    end

    def parse_medium(src)
      src.strip
    end

    def parse_subject_lcsh(src)
      src.strip
    end

    def parse_keyword(src)
      src.strip
    end

    def parse_subject_local_keyword(src)
      src.strip
    end

    def parse_subject_subj_name(src)
      src.strip
    end

    def parse_alternative_title(src)
      src.strip
    end

    def parse_series_title(src)
      src.strip
    end

    def parse_culture(src)
      src.strip
    end

    # 'AttributedArtistCalculation', 'OtherArtistCalculation'
    def parse_creator(src)
      data = artist_to_hash(src)
      role_code = data['ArtistRoleCode']

      if role_code && Role_codes_creator[role_code]
        "#{data['Artist']}, #{data['ArtistRole']}"
      end
    end

    # 'AttributedArtistCalculation', 'OtherArtistCalculation'
    def parse_contributor(src)
      data = artist_to_hash(src)
      role_code = data['ArtistRoleCode']

      if role_code && Role_codes_contributor[role_code]
        "#{data['Artist']}, #{data['ArtistRole']}"
      end
    end

    def parse_provenance(src)
      # 'AttributedArtistCalculation', 'OtherArtistCalculation'
      data = artist_to_hash(src)
      if data
        role_code = data['ArtistRoleCode']
        if role_code && Role_codes_donor[role_code]
          "#{data['Artist']}, #{data['ArtistRole']}"
        end
      else
        # 'Provenance'
        src.strip
      end
    end

    def parse_subject(src)
      # 'AttributedArtistCalculation', 'OtherArtistCalculation'
      data = artist_to_hash(src)
      if data
        role_code = data['ArtistRoleCode']
        if role_code && Role_codes_subject[role_code]
          "#{data['Artist']}, #{data['ArtistRole']}"
        end
      else
        # 'SubjectLCSH', 'LCSubjectNames'
        src.strip
      end
    end

    def parse_genre(src)
      # 'SubjectTMG', 'TypeOfWork'
      src.strip
    end

    def parse_genre_tgm(src)
      # 'SubjectTMG'
      src.strip
    end

    def parse_genre_aat(src)
      # 'TypeOfWork'
      src.strip
    end

    def parse_description(src)
      # 'Abstract'
      if (src.length > 200)
        (src.slice(0..200) + '...')
      else
        src
      end
    end

    def parse_date_created(src)
      # 'DateCalculation'
      src.sub('DateType: ', '').sub('Day: ', '').sub(' A.D.', '').sub('--', '').sub(';', '').strip
    end

    private

    # AttributedArtistRole
    # AttributedArtistRoleCode
    # AttributedArtist
    # OtherArtistRole
    # OtherArtistRoleCode
    # OtherArtist
    def artist_to_hash(src)
      return nil unless src.include?('OtherArtist') || src.include?('AttributedArtist')
      array = src.gsub('Attributed', '').gsub('Other', '').split(';')
      # substitue ' : ' in strings, we only want to split on ': '
      Hash[ array.map { |el| el.gsub(' : ', '---').split(':').map { |s| s.strip.gsub('---', ' : ') } } ]
    end
  end
end

module TcdMetadata
  class MODSRecord < MODSDocument
    def initialize(id, source)
      # JL: The caller sends the whole XML file, so need to just pull mods node for current recordIdentifier
      @id = id
      @source = source
      @all_mods = Nokogiri::XML(source)
      @elements = @all_mods.xpath("//*[name()='mods']")
      @elements.each do | elem |
        if elem.to_s.include? "#{id}</recordIdentifier>"
          @mods = elem
        end
      end

    end

    attr_reader :id, :source

    # JL to do: I removed idenfifier from here (shelf mark?)
    # local metadata
    ATTRIBUTES = %w[
      source_metadata_identifier
      title
      shelfLocator
      folder_number
      digital_root_number
    ].freeze

    def attributes
      ATTRIBUTES.map { |att| [att, send(att)] }.to_h.compact
    end

    def source_metadata_identifier
      ark_id
    end

  end
end

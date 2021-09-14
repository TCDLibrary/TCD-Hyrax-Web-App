module TcdMetadata
  class MarcXmlRecord < MarcXmlDocument
    def initialize(id, source)
      # JL: The caller sends the whole XML file, so need to just pull marc:record node for current recordIdentifier
      @id = id
      @source = source
      @marcxml = Nokogiri::XML(source)
      #byebug
      #@elements = @all_marcxml.xpath("//*[name()='record']")
      #@elements.each do | elem |
      #  #byebug
      #  if elem.to_s.include? "#{id}</controlfield>"
      #    @marcxml = elem
      #  end
      #end

    end

    attr_reader :id, :source

    # local metadata
    ATTRIBUTES = %w[
      source_metadata_identifier
      title
    ].freeze

    def attributes
      ATTRIBUTES.map { |att| [att, send(att)] }.to_h.compact
    end

    def source_metadata_identifier
      ark_id
    end

  end
end

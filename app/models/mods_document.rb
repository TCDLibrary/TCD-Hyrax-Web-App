class MODSDocument # < Nokogiri::XML::Document
  include ModsStructure
  attr_reader :source_file

  def initialize(mods_file)
    #byebug
    @source_file = mods_file
    @all_mods = File.open(@source_file) { |f| Nokogiri::XML(f) }
  end

  def ark_id
    #byebug
    @mods.xpath("//recordIdentifier").text
  end

  def title
    @mods.xpath("titleInfo[not(@type)]/title").text
  end

  def shelfLocator
  # JL to do: This is just a test, not correct MODS field name
    @mods.xpath("location/shelfLocator").text
  end

  # JL to do: This is just a test, not correct MODS field name
  def folder_number
    #byebug
    @mods.xpath("ProjectName").text
  end

  # JL to do: This is just a test, not correct MODS field name
  def digital_root_number
  # JL to do: This is just a test, not correct MODS field name
    #byebug
    @mods.xpath("CatNo").text
  end

  def genre
    # JL to do: requires proper mapping, this was a test. Watch out for multiple values too
    # JL        look at .entries.count
    #byebug
    @mods.xpath("genre[@authority='marcgt']").text
  end

  def abstract
    # JL to do: requires proper mapping, this was a test. Watch out for multiple values too
    # JL        look at .entries.count
    #byebug
    @mods.xpath("abstract").text
  end

end

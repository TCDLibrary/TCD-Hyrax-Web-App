class MarcXmlDocument # < Nokogiri::XML::Document
  include MarcXmlStructure
  attr_reader :source_file

  def initialize(marcxml_file)
    #byebug
    @source_file = marcxml_file
    @all_marcxml = File.open(@source_file) { |f| Nokogiri::XML(f) }
  end

  def ark_id
    #byebug
    @marcxml.xpath("//controlfield[@tag='001']").text
  end

  def title
    @marcxml.xpath("datafield[@tag='245']/subfield[@code='a'] | datafield[@tag='245']/subfield[@code='b'] | datafield[@tag='245']/subfield[@code='n'] | datafield[@tag='245']/subfield[@code='p']").text
  end

  def genres
    @marcxml.xpath("datafield[@tag='655']")
  end

  def abstracts
    @marcxml.xpath("datafield[@tag='520']")
  end

  def identifiers
    @marcxml.xpath("datafield[@tag='534']/subfield[@code='o']")
  end

  def locations
    @marcxml.xpath("datafield[@tag='534']/subfield[@code='l']")
  end

  def creators
    @marcxml.xpath("datafield[@tag='100'] | datafield[@tag='110'] | datafield[@tag='111'] | datafield[@tag='700'] | datafield[@tag='710'] | datafield[@tag='711']")
  end

  def contributors
    @marcxml.xpath("datafield[@tag='100'] | datafield[@tag='110'] | datafield[@tag='111'] | datafield[@tag='700'] | datafield[@tag='710'] | datafield[@tag='711']")
  end

  def publisher_locations
    @marcxml.xpath("datafield[@tag='264']/subfield[@code='a']")
  end

  def publishers
    @marcxml.xpath("datafield[@tag='264']/subfield[@code='b']")
  end

  def dates_created
    @marcxml.xpath("datafield[@tag='264']/subfield[@code='c']")
  end

  def languages
    @marcxml.xpath("datafield[@tag='041']/subfield[@code='a']")
  end

  def related_urls
    @marcxml.xpath("datafield[@tag='545']/subfield[@code='u'] | datafield[@tag='555']/subfield[@code='u']")
  end

  def sponsors
    @marcxml.xpath("datafield[@tag='536']/subfield[@code='a']")
  end

  def subjects_and_keywords
    @marcxml.xpath("datafield[@tag='600'] | datafield[@tag='610'] | datafield[@tag='611'] | datafield[@tag='647'] | datafield[@tag='648'] | datafield[@tag='650'] | datafield[@tag='651']")
  end

  def resource_types
    @marcxml.xpath("datafield[@tag='336']/subfield[@code='a']")
  end

  def mediums
    @marcxml.xpath("datafield[@tag='340']/subfield[@code='c']")
  end

  def supports
    @marcxml.xpath("datafield[@tag='340']/subfield[@code='a'] | datafield[@tag='340']/subfield[@code='e']")
  end

  def digital_object_identifier
    @marcxml.xpath("datafield[@tag='019']/subfield[@code='e']").text
  end

  def folder_number
    @marcxml.xpath("datafield[@tag='019']/subfield[@code='b']").text
  end

  def digital_root_number
    @marcxml.xpath("datafield[@tag='019']/subfield[@code='d']").text
  end

  def image_range
    @marcxml.xpath("datafield[@tag='019']/subfield[@code='f']").text
  end

  def dris_unique
    @marcxml.xpath("//controlfield[@tag='001']").text
  end

  def project_number
    @marcxml.xpath("datafield[@tag='019']/subfield[@code='c']").text
  end

  def biographical_notes
    @marcxml.xpath("datafield[@tag='545']/subfield[@code='a']")
  end

  def finding_aids
    @marcxml.xpath("datafield[@tag='555']/subfield[@code='a']")
  end

  def alternative_titles
    @marcxml.xpath("datafield[@tag='246']")
  end

  def physical_extents
    @marcxml.xpath("datafield[@tag='300']")
  end

  def series_titles
    @marcxml.xpath("datafield[@tag='490']")
  end

  def provenances
    @marcxml.xpath("datafield[@tag='561'][@ind1=' '] | datafield[@tag='561'][@ind1='1'] ")
  end

  def bibliographys
    @marcxml.xpath("datafield[@tag='510']/subfield[@code='a']")
  end

  def notes
    @marcxml.xpath("datafield[@tag='546']/subfield[@code='a']")
  end

  def collection_titles
    @marcxml.xpath("datafield[@tag='773']")
  end

  def sub_fonds
    @marcxml.xpath("datafield[@tag='773'] | datafield[@tag='774']")
  end
end

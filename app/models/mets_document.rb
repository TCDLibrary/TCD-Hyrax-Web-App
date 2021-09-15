class METSDocument
  include MetsStructure
  attr_reader :source_file

  def initialize(mets_file)
    @source_file = mets_file
    @mets = File.open(@source_file) { |f| Nokogiri::XML(f) }
  end

  def ark_id
    @mets.xpath("/mets:mets/@OBJID").to_s
  end

  def bib_id
    @mets.xpath("/mets:mets/mets:dmdSec/mets:mdRef/@xlink:href") \
         .to_s.gsub(/.*\//, '')
  end

  def collection_slugs
    @mets.xpath("/mets:mets/mets:structMap[@TYPE='RelatedObjects']" \
                "//mets:div[@TYPE='IsPartOf']/@CONTENTIDS").to_s
  end

  def pudl_id
    @mets.xpath("/mets:mets/mets:metsHdr/mets:metsDocumentID")
         .first.content.gsub(/\.mets/, '')
  end

  def thumbnail_path
    xp = "/mets:mets/mets:fileSec/mets:fileGrp[@USE='thumbnail']" \
    "/mets:file/mets:FLocat/@xlink:href"
    @mets.xpath(xp).to_s
  end

  def viewing_direction
    right_to_left ? "right-to-left" : "left-to-right"
  end

  def right_to_left
    @mets.xpath("/mets:mets/mets:structMap[@TYPE='logical']/mets:div/@TYPE") \
         .to_s.start_with? 'RTL'
  end

  def multi_volume?
    volume_nodes.length > 1
  end

  def volume_ids
    volume_nodes.map do |vol|
      vol.attribute("ID").value
    end
  end

  def label_for_volume(volume_id)
    volume_node = volume_nodes.find do |vol|
      vol.attribute("ID").value == volume_id
    end
    return volume_node.attribute("FILEID").value if volume_node
  end

  def files_for_volume(volume_id)
    @mets.xpath("//mets:div[@ID='#{volume_id}']//mets:fptr/@FILEID") \
         .map do |file_id|
      file_info(@mets.xpath("//mets:file[@ID='#{file_id.value}']"))
    end
  end

  def files
    @mets.xpath("/mets:mets/mets:fileSec/mets:fileGrp" \
                "/mets:file").map do |f|
      file_info(f)
    end
  end

  def file_info(file)
    {
      id: file.xpath('@ID').to_s,
      checksum: file.xpath('@CHECKSUM').to_s,
      mime_type: file.xpath('@MIMETYPE').to_s,
      url: final_url(file),
      file_name: file.xpath('@ID').to_s
    }
  end

  def file_opts(file)
    return {} if
      @mets.xpath("count(//mets:div/mets:fptr[@FILEID='#{file[:id]}'])") \
           .to_i.positive?
    { viewing_hint: 'non-paged' }
  end

  def decorated_file(f)
    IoDecorator.new(File.open(f[:path]),
                    f[:mime_type],
                    File.basename(f[:path]))
  end

  private

    def volume_nodes
      xp = "/mets:mets/mets:structMap[@TYPE='logical']" \
      "/mets:div[@TYPE='MultiVolumeSet']/mets:div"
      @volume_nodes ||= @mets.xpath(xp)
    end

    def final_url(file)
      url = file.xpath('mets:FLocat/@xlink:href').to_s
      #return unless url.present?

      fl = if url.present?
             TcdMetadata::FinalRedirectUrl.final_redirect_url(url)
           end

      fl.present? ? fl : url
    end
end

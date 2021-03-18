class ExportDublinCoreJob < ApplicationJob
  queue_as :export

  def perform(work_array, tree = false)

    work_array.each do | work |
      #work = work_array[0]
      puts work.id
      puts tree

      our_xml = make_dublin_core(work)

      #make a file with name Rails.application.config.export_folder + work.id + "-DublinCore-" + DateTime.now.to_s(:db) + ".xml"
      File.open(Rails.application.config.export_folder + work.id + "-DublinCore-" + Date.today.to_s(:db) + ".xml", "w") { |f| f.write our_xml }

      byebug
    end
  end

  private

  def make_dublin_core(work)

    if !work.id.blank?
       builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.qualifieddc('xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                       'xmlns:dc' => "http://purl.org/dc/elements/1.1/",
                       #'xsi:schemaLocation' => "http://purl.org/dc/elements/1.1/dc.xsd",
                       'xmlns:dcterms' => "http://purl.org/dc/terms/",
                       #'xmlns:marcrel' => "http://www.loc.gov/marc.relators/",
                       'xsi:schemaLocation' => "http://www.loc.gov/marc.relators/marcrel.xsd",
                       #'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                       'xsi:noNamespaceSchemaLocation' => "http://dublincore.org/schemas/xmls/qdc/2008/02/11/qualifieddc.xsd" ) {

            # need work loop here ##

            ##
            ## See http://www.ukoln.ac.uk/metadata/dcmi/dcxml/xml/example7.xml
            ##
            work.title.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:title', attribute)
              end
            end

            work.creator.each do |attribute|
              if !attribute.blank?
                 Role_codes_creator.each_value {|value|
                   if value.in? attribute
                   then
                      attribute = attribute.delete_suffix(", " + value)
                   end
                 }
                 xml.send('dc:creator', attribute)
              end
            end

            work.location.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:creator', attribute)
              end
            end

            work.subject.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:subject', attribute)
              end
            end

            work.abstract.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:description', attribute)
              end
            end

            work.sponsor.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:description', attribute)
              end
            end

            work.publisher.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:publisher', attribute)
              end
            end

            work.contributor.each do |attribute|
              if !attribute.blank?
                Role_codes_contributor.each_value {|value|
                  if value.in? attribute
                  then
                     attribute = attribute.delete_suffix(", " + value)
                  end
                }
                xml.send('dc:contributor', attribute)
                 #xml.send('marcrel:rcp', attribute)
              end
            end

            work.date_created.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:created', attribute)
              end
            end

            if !work.date_uploaded.blank?
              xml.send('dcterms:dateSubmitted', work.date_uploaded.to_date.iso8601)
            end

            if !work.date_modified.blank?
              xml.send('dcterms:modified', work.date_modified.to_date.iso8601)
            end

            work.resource_type.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:type', attribute.camelize)
              end
            end

            work.identifier.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:identifier', attribute)
              end
            end

            if !work.doi.blank?
                 xml.send('dc:identifier', 'DOI: ' + work.doi)
            end


            ###xml.send('dc:identifier', request.referrer)

            work.language.each do |attribute|
              if !attribute.blank?
                 lang = Iso639[attribute]

                 if lang.present?
                    xml.send('dc:language', Iso639[attribute].english_name)
                 end
              end
            end

            #work.copyright_status.each do |attribute|
            #work.rights_statement.each do |attribute|
            work.copyright_note.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:rights', attribute)
              end
            end

            work.rights_statement.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:rights', attribute)
              end
            end

            work.copyright_status.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:rights', attribute)
              end
            end

            work.license.each do |attribute|
              if !attribute.blank?
                 xml.send('dcterms:license', attribute)
              end
            end
            # TODO: why is this not on the object?
            #rights	::RDF::Vocab::DC.rights	TRUE

            work.bibliographic_citation.each do |attribute|
              if !attribute.blank?
                 xml.send('dcterms:bibliographicCitation', attribute)
              end
            end

            work.genre_tgm.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:type', attribute)
              end
            end

            work.genre_aat.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:type', attribute)
              end
            end

            work.provenance.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:provenance', attribute)
              end
            end

            work.series_title.each do |attribute|
              if !attribute.blank?
                 xml.send('dcterms:isPartOf', attribute)
              end
            end

            work.collection_title.each do |attribute|
              if !attribute.blank?
                 xml.send('dcterms:isPartOf', attribute)
              end
            end

            work.alternative_title.each do |attribute|
              if !attribute.blank?
                 xml.send('dcterms:alternative', attribute)
              end
            end

            work.genre.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:type', attribute)
              end
            end

            work.support.each do |attribute|
              if !attribute.blank?
                 xml.send('dcterms:medium', attribute)
              end
            end

            work.related_url.each do |attribute|
              if !attribute.blank?
                 xml.send('dc:relation', attribute)
              end
            end

           # end of work loop
          }
        end


      #respond_to do |format|
      #  format.html
      #  format.xml { render xml: builder  }
      #end

      byebug
      return builder.to_xml

    end # if !work.id.blank?

  end

end

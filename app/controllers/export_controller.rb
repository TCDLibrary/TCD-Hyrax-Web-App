class ExportController < ApplicationController
  include Hydra::Controller::ControllerBehavior
  #require 'iso-639'

  def dublinCore

    objectId = params[:id]

    owner_rec = Work.new

    if objectId != '000000000'
      begin
          owner_rec = Work.find(objectId)
      rescue
          begin
            owner_rec = Folio.find(objectId)
          rescue
            owner_rec = Subseries.find(objectId)
          end
      end

      if !owner_rec.id.blank?
         builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
            xml.qualifieddc('xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                         'xmlns:dc' => "http://purl.org/dc/elements/1.1/",
                         #'xsi:schemaLocation' => "http://purl.org/dc/elements/1.1/dc.xsd",
                         'xmlns:dcterms' => "http://purl.org/dc/terms/",
                         #'xmlns:marcrel' => "http://www.loc.gov/marc.relators/",
                         'xsi:schemaLocation' => "http://www.loc.gov/marc.relators/marcrel.xsd",
                         #'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                         'xsi:noNamespaceSchemaLocation' => "http://dublincore.org/schemas/xmls/qdc/2008/02/11/qualifieddc.xsd" ) {

              owner_rec.title.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:title', attribute)
                end
              end

              owner_rec.creator.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:creator', attribute)
                end
              end

              owner_rec.subject.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:subject', attribute)
                end
              end

              owner_rec.abstract.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:description', attribute)
                end
              end

              owner_rec.publisher.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:publisher', attribute)
                end
              end

              owner_rec.contributor.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:contributor', attribute)
                   #xml.send('marcrel:rcp', attribute)
                end
              end

              owner_rec.date_created.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:created', attribute)
                end
              end

              if !owner_rec.date_uploaded.blank?
                xml.send('dcterms:dateSubmitted', owner_rec.date_uploaded.to_date.iso8601)
              end

              if !owner_rec.date_modified.blank?
                xml.send('dcterms:modified', owner_rec.date_modified.to_date.iso8601)
              end

              owner_rec.resource_type.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:type', attribute.camelize)
                end
              end

              owner_rec.identifier.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:identifier', attribute)
                end
              end

              if !owner_rec.doi.blank?
                   xml.send('dc:identifier', 'DOI: ' + owner_rec.doi)
              end


              xml.send('dc:identifier', request.referrer)

              owner_rec.language.each do |attribute|
                if !attribute.blank?
                   lang = Iso639[attribute]

                   if lang.present?
                      xml.send('dc:language', Iso639[attribute].english_name)
                   end
                end
              end

              #owner_rec.copyright_status.each do |attribute|
              #owner_rec.rights_statement.each do |attribute|
              owner_rec.copyright_note.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:rights', attribute)
                end
              end

              # TODO: why is this not on the object?
              #rights	::RDF::Vocab::DC.rights	TRUE

              owner_rec.bibliographic_citation.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:bibliographicCitation', attribute)
                end
              end

              owner_rec.genre_tgm.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:type', attribute)
                end
              end

              owner_rec.genre_aat.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:type', attribute)
                end
              end

              owner_rec.provenance.each do |attribute|
                if !attribute.blank?
                   xml.send('dc:provenance', attribute)
                end
              end

            }
          end


        respond_to do |format|
          format.html
          format.xml { render xml: builder  }
        end
      end # if !owner_rec.id.blank?
    end
  end
end

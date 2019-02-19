class ExportController < ApplicationController
  include Hydra::Controller::ControllerBehavior

  def dublinCore

    objectId = params[:id]

    owner_rec = Work.new

    if objectId != '000000000'
      begin
          owner_rec = Work.find(objectId)
      rescue
          owner_rec = Folio.find(objectId)
      end

      if !owner_rec.id.blank?
         builder = Nokogiri::XML::Builder.new do |xml|
            xml.metadata('xmlns:dc' => "http://purl.org/dc/elements/1.1/", 'xmlns:dcterms' => "http://purl.org/dc/terms/") {

              if !owner_rec.title[0].blank?
                xml.send('dc:title', owner_rec.title[0])
              end

              if !owner_rec.creator[0].blank?
                xml.send('dc:creator', owner_rec.creator[0])
              end

              if !owner_rec.subject[0].blank?
                xml.send('dc:subject', owner_rec.subject[0])
              end

              if !owner_rec.description[0].blank?
                xml.send('dc:description', owner_rec.description[0])
              end

              if !owner_rec.publisher[0].blank?
                xml.send('dc:publisher', owner_rec.publisher[0])
              end

              if !owner_rec.contributor[0].blank?
                xml.send('dc:contributor', owner_rec.contributor[0])
              end

              if !owner_rec.date_created[0].blank?
                xml.send('dcterms:created', owner_rec.date_created[0])
              end

              if !owner_rec.date_uploaded.blank?
                xml.send('dc:dateSubmitted', owner_rec.date_uploaded)
              end

              if !owner_rec.date_modified.blank?
                xml.send('dc:modified', owner_rec.date_modified)
              end

              if !owner_rec.resource_type[0].blank?
                xml.send('dc:type', owner_rec.resource_type[0])
              end

              if !owner_rec.identifier[0].blank?
                xml.send('dc:identifier', owner_rec.identifier[0])
              end

              if !owner_rec.language[0].blank?
                xml.send('dc:language', owner_rec.language[0])
              end

              if !owner_rec.copyright_status[0].blank?
                xml.send('dc:rights', owner_rec.copyright_status[0])
              end

              #language	::RDF::Vocab::DC11.language	TRUE

              # TODO: why is this not on the object?
              #rights	::RDF::Vocab::DC.rights	TRUE

              if !owner_rec.bibliographic_citation[0].blank?
                xml.send('dc:bibliographicCitation', owner_rec.bibliographic_citation[0])
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

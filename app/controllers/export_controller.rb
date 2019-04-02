class ExportController < ApplicationController
  include Hydra::Controller::ControllerBehavior

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
         builder = Nokogiri::XML::Builder.new do |xml|
            xml.metadata('xmlns:dc' => "http://purl.org/dc/elements/1.1/", 'xmlns:dcterms' => "http://purl.org/dc/terms/") {

              owner_rec.title.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:title', attribute)
                end
              end

              owner_rec.creator.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:creator', attribute)
                end
              end

              owner_rec.subject.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:subject', attribute)
                end
              end

              owner_rec.description.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:description', attribute)
                end
              end

              owner_rec.publisher.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:publisher', attribute)
                end
              end

              owner_rec.contributor.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:contributor', attribute)
                end
              end

              owner_rec.date_created.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:created', attribute)
                end
              end

              if !owner_rec.date_uploaded.blank?
                xml.send('dcterms:dateSubmitted', owner_rec.date_uploaded)
              end

              if !owner_rec.date_modified.blank?
                xml.send('dcterms:modified', owner_rec.date_modified)
              end

              owner_rec.resource_type.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:type', attribute)
                end
              end

              owner_rec.identifier.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:identifier', attribute)
                end
              end

              xml.send('dcterms:identifier', request.original_url)

              owner_rec.language.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:language', attribute)
                end
              end

              owner_rec.copyright_status.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:rights', attribute)
                end
              end

              # TODO: why is this not on the object?
              #rights	::RDF::Vocab::DC.rights	TRUE

              owner_rec.bibliographic_citation.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:bibliographicCitation', attribute)
                end
              end

              owner_rec.genre.each do |attribute|
                if !attribute.blank?
                   xml.send('dcterms:type', attribute)
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

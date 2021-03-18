module Hyrax
  module WorkBehavior
    extend ActiveSupport::Concern
    include Hydra::Works::WorkBehavior
    include HumanReadableType
    include Hyrax::Noid
    include Permissions
    include Serializers
    include Hydra::WithDepositor
    include Solrizer::Common
    include HasRepresentative
    include HasRendering
    include WithFileSets
    include Naming
    include CoreMetadata
    include InAdminSet
    include Hydra::AccessControls::Embargoable
    include GlobalID::Identification
    include NestedWorks
    include Suppressible
    include ProxyDeposit
    include Works::Metadata
    include WithEvents
    include Hyrax::CollectionNesting

    included do
      property :owner, predicate: RDF::URI.new('http://opaquenamespace.org/ns/hydra/owner'), multiple: false
      class_attribute :human_readable_short_description
      # TODO: do we need this line?
      self.indexer = WorkIndexer
    end

    # TODO: This can be removed when we upgrade to ActiveFedora 12.0
    def etag
      raise "Unable to produce an etag for a unsaved object" unless persisted?
      ldp_source.head.etag
    end

    module ClassMethods
      # This governs which partial to draw when you render this type of object
      def _to_partial_path #:nodoc:
        @_to_partial_path ||= begin
          element = ActiveSupport::Inflector.underscore(ActiveSupport::Inflector.demodulize(name))
          collection = ActiveSupport::Inflector.tableize(name)
          "hyrax/#{collection}/#{element}".freeze
        end
      end
    end


    def to_dublin_core
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
         xml.qualifieddc('xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                      'xmlns:dc' => "http://purl.org/dc/elements/1.1/",
                      #'xsi:schemaLocation' => "http://purl.org/dc/elements/1.1/dc.xsd",
                      'xmlns:dcterms' => "http://purl.org/dc/terms/",
                      #'xmlns:marcrel' => "http://www.loc.gov/marc.relators/",
                      'xsi:schemaLocation' => "http://www.loc.gov/marc.relators/marcrel.xsd",
                      #'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
                      'xsi:noNamespaceSchemaLocation' => "http://dublincore.org/schemas/xmls/qdc/2008/02/11/qualifieddc.xsd" ) {

           # need self loop here ##

           ##
           ## See http://www.ukoln.ac.uk/metadata/dcmi/dcxml/xml/example7.xml
           ##
           self.title.each do |attribute|
             if !attribute.blank?
                xml.send('dc:title', attribute)
             end
           end

           self.creator.each do |attribute|
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

           self.location.each do |attribute|
             if !attribute.blank?
                xml.send('dc:creator', attribute)
             end
           end

           self.subject.each do |attribute|
             if !attribute.blank?
                xml.send('dc:subject', attribute)
             end
           end

           self.abstract.each do |attribute|
             if !attribute.blank?
                xml.send('dc:description', attribute)
             end
           end

           self.sponsor.each do |attribute|
             if !attribute.blank?
                xml.send('dc:description', attribute)
             end
           end

           self.publisher.each do |attribute|
             if !attribute.blank?
                xml.send('dc:publisher', attribute)
             end
           end

           self.contributor.each do |attribute|
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

           self.date_created.each do |attribute|
             if !attribute.blank?
                xml.send('dc:created', attribute)
             end
           end

           if !self.date_uploaded.blank?
             xml.send('dcterms:dateSubmitted', self.date_uploaded.to_date.iso8601)
           end

           if !self.date_modified.blank?
             xml.send('dcterms:modified', self.date_modified.to_date.iso8601)
           end

           self.resource_type.each do |attribute|
             if !attribute.blank?
                xml.send('dc:type', attribute.camelize)
             end
           end

           self.identifier.each do |attribute|
             if !attribute.blank?
                xml.send('dc:identifier', attribute)
             end
           end

           if !self.doi.blank?
                xml.send('dc:identifier', 'DOI: ' + self.doi)
           end


           ###xml.send('dc:identifier', request.referrer)

           self.language.each do |attribute|
             if !attribute.blank?
                lang = Iso639[attribute]

                if lang.present?
                   xml.send('dc:language', Iso639[attribute].english_name)
                end
             end
           end

           #self.copyright_status.each do |attribute|
           #self.rights_statement.each do |attribute|
           self.copyright_note.each do |attribute|
             if !attribute.blank?
                xml.send('dc:rights', attribute)
             end
           end

           self.rights_statement.each do |attribute|
             if !attribute.blank?
                xml.send('dc:rights', attribute)
             end
           end

           self.copyright_status.each do |attribute|
             if !attribute.blank?
                xml.send('dc:rights', attribute)
             end
           end

           self.license.each do |attribute|
             if !attribute.blank?
                xml.send('dcterms:license', attribute)
             end
           end
           # TODO: why is this not on the object?
           #rights	::RDF::Vocab::DC.rights	TRUE

           self.bibliographic_citation.each do |attribute|
             if !attribute.blank?
                xml.send('dcterms:bibliographicCitation', attribute)
             end
           end

           self.genre_tgm.each do |attribute|
             if !attribute.blank?
                xml.send('dc:type', attribute)
             end
           end

           self.genre_aat.each do |attribute|
             if !attribute.blank?
                xml.send('dc:type', attribute)
             end
           end

           self.provenance.each do |attribute|
             if !attribute.blank?
                xml.send('dc:provenance', attribute)
             end
           end

           self.series_title.each do |attribute|
             if !attribute.blank?
                xml.send('dcterms:isPartOf', attribute)
             end
           end

           self.collection_title.each do |attribute|
             if !attribute.blank?
                xml.send('dcterms:isPartOf', attribute)
             end
           end

           self.alternative_title.each do |attribute|
             if !attribute.blank?
                xml.send('dcterms:alternative', attribute)
             end
           end

           self.genre.each do |attribute|
             if !attribute.blank?
                xml.send('dc:type', attribute)
             end
           end

           self.support.each do |attribute|
             if !attribute.blank?
                xml.send('dcterms:medium', attribute)
             end
           end

           self.related_url.each do |attribute|
             if !attribute.blank?
                xml.send('dc:relation', attribute)
             end
           end

          # end of self loop
         }
       end

       return builder.to_xml
    end
  end
end

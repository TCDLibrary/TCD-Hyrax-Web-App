module Bulkrax
  class MarcXmlCollectionEntry < MarcXmlEntry
    def build_metadata
      self.parsed_metadata = {
        Bulkrax.system_identifier_field => parent.send(Bulkrax.system_identifier_field)
      }
    end

    def factory_class
      parent.class
    end
  end
end

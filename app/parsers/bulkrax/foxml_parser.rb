module Bulkrax
  class FoxmlParser < XmlParser
    def record_element
      'ROW'
    end

    def entry_class
      Bulkrax::FoxmlEntry
    end

  end
end

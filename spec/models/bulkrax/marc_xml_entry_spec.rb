# frozen_string_literal: true

require 'rails_helper'

module Bulkrax
  RSpec.describe MarcXmlEntry, type: :model do
    let(:path) { './spec/fixtures/MARC to XML for HYRAX testing.xml' }
    let(:data) { described_class.read_data(path) }

    describe 'class methods' do
      context '#read_data' do
        it 'reads the data from an xml file' do
          expect(described_class.read_data(path)).to be_a(Nokogiri::XML::Document)
        end
      end

      context '#data_for_entry' do
        it 'retrieves the data and constructs a hash' do
          expect(described_class.data_for_entry(data)).to eq(
            source_identifier: 'Jmarc0713',
            data: "<collection schemaLocation=\"http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd\">  <record>    <leader>07890nam a22009255i 4500</leader>    <controlfield tag=\"001\">Jmarc0713</controlfield>    <controlfield tag=\"003\">IeDuTC</controlfield>    <controlfield tag=\"006\">m o j </controlfield>    <controlfield tag=\"007\">cr c| a|a|a</controlfield>    <controlfield tag=\"008\">200929s1823 ie abf o 000 0 eng c</controlfield>    <datafield tag=\"019\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">DC Repository; NOT FOR PUBLIC VIEW; map to Hyrax only</subfield>    </datafield>    <datafield tag=\"019\" ind1=\" \" ind2=\" \">      <subfield code=\"b\">901</subfield>      <subfield code=\"c\">1234</subfield>      <subfield code=\"d\">MS4053</subfield>      <subfield code=\"e\">digital obj id</subfield>      <subfield code=\"f\">001:009</subfield>    </datafield>    <datafield tag=\"020\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">01234567XX</subfield>      <subfield code=\"q\">(paperback)</subfield>    </datafield>    <datafield tag=\"020\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">97801234567XX</subfield>      <subfield code=\"q\">(paperback)</subfield>    </datafield>    <datafield tag=\"040\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">IeDuTC</subfield>      <subfield code=\"b\">eng</subfield>      <subfield code=\"e\">rda</subfield>      <subfield code=\"c\">IeDuTC</subfield>    </datafield>    <datafield tag=\"041\" ind1=\"0\" ind2=\" \">      <subfield code=\"a\">eng</subfield>      <subfield code=\"a\">fre</subfield>    </datafield>    <datafield tag=\"100\" ind1=\"1\" ind2=\" \">      <subfield code=\"a\">Sherwood,</subfield>      <subfield code=\"c\">Mrs.</subfield>      <subfield code=\"q\">(Mary Martha),</subfield>      <subfield code=\"d\">1775-1851,</subfield>      <subfield code=\"e\">author.</subfield>    </datafield>    <datafield tag=\"245\" ind1=\"1\" ind2=\"2\">      <subfield code=\"a\">A drive in the coach through the streets of London :</subfield>      <subfield code=\"b\">a story founded on fact /</subfield>      <subfield code=\"c\">by Mrs. Sherwood.</subfield>    </datafield>    <datafield tag=\"246\" ind1=\"3\" ind2=\"8\">      <subfield code=\"a\">A coach ride around London for young ladies</subfield>    </datafield>    <datafield tag=\"246\" ind1=\"3\" ind2=\"4\">      <subfield code=\"a\">Julias coach ride around London</subfield>    </datafield>    <datafield tag=\"246\" ind1=\"3\" ind2=\"5\">      <subfield code=\"a\">A coach drive for Julia and a lesson learned</subfield>    </datafield>    <datafield tag=\"250\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Eighth edition.</subfield>    </datafield>    <datafield tag=\"264\" ind1=\" \" ind2=\"3\">      <subfield code=\"a\">Wellington, Salop [Shropshire] :</subfield>      <subfield code=\"b\">printed by and for F. Houlston and Son,</subfield>      <subfield code=\"c\">1823.</subfield>    </datafield>    <datafield tag=\"264\" ind1=\" \" ind2=\"3\">      <subfield code=\"a\">Trinity College Dublin:</subfield>      <subfield code=\"b\">printed by and for TCD</subfield>      <subfield code=\"c\">2021</subfield>    </datafield>    <datafield tag=\"300\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">v, 45 pages, 6 unnumbered leaves of plates :</subfield>      <subfield code=\"b\">illustrations (black and white), map ;</subfield>      <subfield code=\"c\">25 cm. +</subfield>      <subfield code=\"e\">1 folded colour map (24 x 37 cm.) </subfield>    </datafield>    <datafield tag=\"336\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">text</subfield>      <subfield code=\"b\">txt</subfield>      <subfield code=\"2\">rdacontent</subfield>    </datafield>    <datafield tag=\"336\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">still image</subfield>      <subfield code=\"b\">sti</subfield>      <subfield code=\"2\">rdacontent</subfield>    </datafield>    <datafield tag=\"336\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">cartographic image</subfield>      <subfield code=\"b\">cri</subfield>      <subfield code=\"2\">rdacontent</subfield>    </datafield>    <datafield tag=\"337\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">unmediated</subfield>      <subfield code=\"b\">n</subfield>      <subfield code=\"2\">rdamedia</subfield>    </datafield>    <datafield tag=\"338\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">volume</subfield>      <subfield code=\"b\">nc</subfield>      <subfield code=\"2\">rdacarrier</subfield>    </datafield>    <datafield tag=\"340\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">paper (fiber product)</subfield>      <subfield code=\"c\">ink</subfield>      <subfield code=\"e\">ink2</subfield>      <subfield code=\"2\">aat</subfield>    </datafield>    <datafield tag=\"380\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">pamphlets</subfield>      <subfield code=\"2\">aat</subfield>    </datafield>    <datafield tag=\"380\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Books</subfield>      <subfield code=\"2\">lctgm</subfield>    </datafield>    <datafield tag=\"490\" ind1=\"1\" ind2=\" \">      <subfield code=\"a\">Miss Primroses Library for Young Ladies ;</subfield>      <subfield code=\"v\">number 6</subfield>    </datafield>    <datafield tag=\"500\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">THIS IS A DUMMY RECORD (INACCURATE); TESTING PURPOSES ONLY.</subfield>    </datafield>    <datafield tag=\"501\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">With a separately titled map on an accompanying sheet: Lady Lucys route around Covent Garden.</subfield>    </datafield>    <datafield tag=\"510\" ind1=\"0\" ind2=\" \">      <subfield code=\"a\">Every day with Jesus / A. Man -- Hope for hard times / A.N. Other -- How to pray / A. Woman -- Devotions for girls / A.N. Otherwoman.</subfield>    </datafield>    <datafield tag=\"520\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">In A Drive in the Coach through the Streets of London, a young girl named Julia is \"granted the privilege of shopping with her mother only if she will \"behave wisely in the streets\" and \"not give [her] mind to self-pleasing.\" Of course, she cannot keep this promise and she eagerly peeks in at every store window and begs her mother to buy her everything she sees. Her mother therefore allows her to select one item from every shop. Julia, ecstatic, chooses, among other things, blue satin boots, a penknife, and a new hat with flowers, until the pair reach the undertakers shop. There her mood droops considerably and she realizes the moral of the lesson, recited by her mother, as she picks out a coffin: \"but she that liveth in pleasure is dead while she liveth\" (1 Timothy 5:6).\" --https://en.wikipedia.org/wiki/Mary_Martha_Sherwood (accessed 29/09/2020).</subfield>    </datafield>    <datafield tag=\"520\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Abstract part 2</subfield>    </datafield>    <datafield tag=\"530\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Original print version available in the Department of Early Printed Books at OLS POL 3811 no.3 ;</subfield>      <subfield code=\"c\">for use in the Department of Early Printed Books only.</subfield>    </datafield>    <datafield tag=\"534\" ind1=\" \" ind2=\" \">      <subfield code=\"p\">Digitised version of:</subfield>      <subfield code=\"t\">A drive in the coach through the streets of London in the</subfield>      <subfield code=\"l\">Department of Early Printed Books,</subfield>      <subfield code=\"o\">OLS POL 3811 no.3.</subfield>    </datafield>    <datafield tag=\"534\" ind1=\" \" ind2=\" \">      <subfield code=\"p\">2222 Digitised version of:</subfield>      <subfield code=\"t\">2222 A drive in the coach through the streets of London in the</subfield>      <subfield code=\"l\">2222 Department of Early Printed Books,</subfield>      <subfield code=\"o\">2222 OLS POL 3811 no.3.</subfield>    </datafield>    <datafield tag=\"535\" ind1=\"1\" ind2=\" \">      <subfield code=\"a\">Library of Trinity College Dublin, Department of Early Printed Books ;</subfield>      <subfield code=\"b\">Trinity College, College Green, Dublin 2;</subfield>      <subfield code=\"c\">Ireland;</subfield>      <subfield code=\"d\">+353(0)1 896 1172</subfield>    </datafield>    <datafield tag=\"536\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Digitisation and metadata creation sponsored by the Bank of America, 2018.</subfield>    </datafield>    <datafield tag=\"536\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">TCD</subfield>    </datafield>    <datafield tag=\"541\" ind1=\"1\" ind2=\" \">      <subfield code=\"3\">Errata supplement (pamphlet, 2 leaves)</subfield>      <subfield code=\"c\">Donation;</subfield>      <subfield code=\"a\">Ms. Jane Doe;</subfield>      <subfield code=\"b\">Poughkeepsie, NY 12601;</subfield>      <subfield code=\"d\">2020;</subfield>      <subfield code=\"f\">Jane Doe Estate;</subfield>      <subfield code=\"n\">1</subfield>      <subfield code=\"o\">pamphlet.</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"545\" ind1=\"0\" ind2=\" \">      <subfield code=\"a\">\"Mary Martha Sherwood (née Butt; 6 May 1775 {u2013} 22 September 1851) was a writer of childrens literature in 19th-century Britain. She composed over 400 books, tracts, magazine articles, and chapbooks. Among her best known works are The History of Little Henry and his Bearer (1814), The History of Henry Milner (1822{u2013}37), and The History of the Fairchild Family (1818{u2013}47). While Sherwood is known primarily for the strong evangelicalism that coloured her early writings, her later works are characterized by common Victorian themes, such as domesticity. Sherwoods childhood was uneventful, although she recalled it as the happiest part of her life. After she married Captain Henry Sherwood and moved to India, she converted to evangelical Christianity and began to write for children. Although her books were initially intended only for the children of the military encampments in India, the British public also received them enthusiastically. The Sherwoods returned to England after a decade in India and, building upon her popularity, Sherwood opened a boarding school and published scores of texts for children and the poor. Many of Sherwoods books were bestsellers and she has been described as \"one of the most significant authors of childrens literature of the nineteenth century\".[1] Her depictions of domesticity and Britains relationship with India may have played a part in shaping the opinions of many young British readers.[2] However, her works fell from favor as a different style of childrens literature came into fashion during the late nineteenth century, one exemplified by Lewis Carrolls playful and nonsensical Alices Adventures in Wonderland.\" See the full Wikipedia entry at</subfield>      <subfield code=\"u\">https://en.wikipedia.org/wiki/Mary_Martha_Sherwood</subfield>    </datafield>    <datafield tag=\"546\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">English, with parallel French translation.</subfield>    </datafield>    <datafield tag=\"555\" ind1=\"0\" ind2=\" \">      <subfield code=\"a\">More for archival/MSS collections, but map anyway</subfield>      <subfield code=\"u\">https://en.wikipedia.org/wiki/Mary_Martha_Sherwood2222</subfield>    </datafield>    <datafield tag=\"561\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">With MS name and date on title page: Margaret W. Woods, 1850. Formerly owned by Mary Paul Pollard, and forms part of the Pollard Collection of childrens books.</subfield>      <subfield code=\"u\">test u</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"561\" ind1=\"1\" ind2=\" \">      <subfield code=\"a\">ind1.</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"561\" ind1=\"3\" ind2=\" \">      <subfield code=\"a\">aaaaa</subfield>      <subfield code=\"u\">uuuu</subfield>    </datafield>    <datafield tag=\"563\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Blue paper covers, printed in black on the front. Bound in a volume with three other items: Mammas gift ... (Edinburgh: Oliver &amp; Boyd, 1829); Swifts Gullivers travels (Edinburgh: Oliver &amp; Boyd, [ca. 1830]); Mrs. Camerons The caskets: or The palace and the church (11th edition: London: Houlston and Son, 1831).</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"580\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Forms part of the Pollard Collection.</subfield>    </datafield>    <datafield tag=\"581\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">Description based on research conducted by Dr. A.N. Academic, Department of English, Trinity College Dublin.</subfield>    </datafield>    <datafield tag=\"583\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">digitised</subfield>      <subfield code=\"c\">20200929</subfield>      <subfield code=\"h\">Library</subfield>      <subfield code=\"i\">photographed</subfield>      <subfield code=\"j\">Digital Collections, The Library of Trinity College Dublin.</subfield>    </datafield>    <datafield tag=\"600\" ind1=\"1\" ind2=\"0\">      <subfield code=\"a\">Sherwood,</subfield>      <subfield code=\"c\">Mrs.</subfield>      <subfield code=\"q\">(Mary Martha),</subfield>      <subfield code=\"d\">1775-1851.</subfield>    </datafield>    <datafield tag=\"610\" ind1=\"2\" ind2=\"0\">      <subfield code=\"a\">F. Houlston and Son.</subfield>    </datafield>    <datafield tag=\"600\" ind1=\"3\" ind2=\"0\">      <subfield code=\"a\">Sherwood family.</subfield>    </datafield>    <datafield tag=\"600\" ind1=\"1\" ind2=\"0\">      <subfield code=\"a\">with $2 Sherwood,</subfield>      <subfield code=\"c\">Mrs.</subfield>      <subfield code=\"q\">(Mary Martha),</subfield>      <subfield code=\"d\">1775-1851.</subfield>      <subfield code=\"2\">local</subfield>    </datafield>    <datafield tag=\"610\" ind1=\"2\" ind2=\"0\">      <subfield code=\"a\">with $2 F. Houlston and Son.</subfield>      <subfield code=\"2\">local</subfield>    </datafield>    <datafield tag=\"600\" ind1=\"3\" ind2=\"0\">      <subfield code=\"a\">with $2 Sherwood family.</subfield>      <subfield code=\"2\">local</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"0\">      <subfield code=\"a\">Avarice</subfield>      <subfield code=\"x\">Religious aspects</subfield>      <subfield code=\"x\">Christianity</subfield>      <subfield code=\"v\">Juvenile fiction.</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"0\">      <subfield code=\"a\">Worldliness</subfield>      <subfield code=\"v\">Juvenile fiction.</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"0\">      <subfield code=\"a\">Christian life</subfield>      <subfield code=\"v\">Juvenile fiction.</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"0\">      <subfield code=\"a\">Mothers and daughters</subfield>      <subfield code=\"v\">Juvenile fiction.</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"0\">      <subfield code=\"a\">Conduct of life</subfield>      <subfield code=\"v\">Juvenile fiction.</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">Avarice</subfield>      <subfield code=\"x\">Religious aspects</subfield>      <subfield code=\"x\">Christianity.</subfield>      <subfield code=\"2\">fast</subfield>      <subfield code=\"0\">(OCoLC)fst00824302</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">Worldliness.</subfield>      <subfield code=\"2\">fast</subfield>      <subfield code=\"0\">(OCoLC)fst01181415</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">Christian life.</subfield>      <subfield code=\"2\">fast</subfield>      <subfield code=\"0\">((OCoLC)fst00859185</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">Mothers and daughters.</subfield>      <subfield code=\"2\">fast</subfield>      <subfield code=\"0\">((OCoLC)fst01026997</subfield>    </datafield>    <datafield tag=\"650\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">Young women</subfield>      <subfield code=\"x\">Conduct of life.</subfield>      <subfield code=\"2\">fast</subfield>      <subfield code=\"0\">(OCoLC)fst01183306</subfield>    </datafield>    <datafield tag=\"655\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">Books.</subfield>      <subfield code=\"2\">lctgm</subfield>    </datafield>    <datafield tag=\"655\" ind1=\" \" ind2=\"7\">      <subfield code=\"a\">pamphlets.</subfield>      <subfield code=\"2\">aat</subfield>    </datafield>    <datafield tag=\"700\" ind1=\"1\" ind2=\" \">      <subfield code=\"a\">Pollard, M.</subfield>      <subfield code=\"q\">(Mary),</subfield>      <subfield code=\"e\">former owner.</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"700\" ind1=\"1\" ind2=\" \">      <subfield code=\"a\">Woods, Margaret W.,</subfield>      <subfield code=\"d\">active 1850,</subfield>      <subfield code=\"e\">former owner.</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"710\" ind1=\"2\" ind2=\" \">      <subfield code=\"a\">Pollard Collection,</subfield>      <subfield code=\"e\">former owner.</subfield>      <subfield code=\"5\">IeDuTC</subfield>    </datafield>    <datafield tag=\"710\" ind1=\"2\" ind2=\" \">      <subfield code=\"a\">F. Houlston and Son,</subfield>      <subfield code=\"e\">printer.</subfield>    </datafield>    <datafield tag=\"710\" ind1=\"2\" ind2=\" \">      <subfield code=\"a\">Bank of America,</subfield>      <subfield code=\"e\">sponsor.</subfield>      <subfield code=\"5\">IeDuTC</subfield>      <subfield code=\"2\">NOT ME!! 710</subfield>    </datafield>    <datafield tag=\"773\" ind1=\"0\" ind2=\" \">      <subfield code=\"i\">Forms part of:</subfield>      <subfield code=\"t\">Pollard Collection</subfield>      <subfield code=\"w\">NO BIB NUMBER FOR THIS</subfield>    </datafield>    <datafield tag=\"776\" ind1=\"0\" ind2=\" \">      <subfield code=\"c\">Print version:</subfield>      <subfield code=\"t\">A drive in the coach through the streets of London</subfield>      <subfield code=\"w\">b145354295</subfield>    </datafield>    <datafield tag=\"830\" ind1=\" \" ind2=\"0\">      <subfield code=\"a\">Miss Primroses library for young ladies ;</subfield>      <subfield code=\"v\">no. 6.</subfield>    </datafield>    <datafield tag=\"850\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">IeDuTC</subfield>    </datafield>    <datafield tag=\"852\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">The Library of Trinity College Dublin</subfield>      <subfield code=\"b\">Department of Early Printed Books</subfield>      <subfield code=\"j\">OLS POL 3811 no.3</subfield>      <subfield code=\"d\">former numbers</subfield>      <subfield code=\"n\">ie</subfield>      <subfield code=\"u\">https://www.tcd.ie/library/epb/</subfield>    </datafield>    <datafield tag=\"907\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">.b190511631</subfield>      <subfield code=\"b\">29-09-20</subfield>      <subfield code=\"c\">29-09-20</subfield>    </datafield>    <datafield tag=\"998\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">none</subfield>      <subfield code=\"b\">29-09-20</subfield>      <subfield code=\"c\">m</subfield>      <subfield code=\"d\">3 </subfield>      <subfield code=\"e\">b</subfield>      <subfield code=\"f\">eng</subfield>      <subfield code=\"g\">ie </subfield>      <subfield code=\"h\">2</subfield>      <subfield code=\"i\">0</subfield>    </datafield>    <datafield tag=\"989\" ind1=\" \" ind2=\" \">      <subfield code=\"a\">21</subfield>    </datafield>  </record></collection>",
            collection: [],
      #      file: [],
            children: []
          )
        end
      end
    end

    describe '#build' do
      subject(:marc_xml_entry) { described_class.new(importerexporter: importer) }
      let(:parent) { nil }
      let(:image_type) { 'Not Now' }
      let(:raw_metadata) { described_class.data_for_entry(data) }
      let(:importer) do
        Bulkrax::Importer.new(
          name: 'Importer',
          admin_set_id: AdminSet::DEFAULT_ID,
          parser_klass: 'Bulkrax::MarcXmlParser',
          parser_fields: {
            'import_file_path' => path,
            object_type: 'Work',
            import_type: 'single',
            image_type: image_type,
            parent_id: parent
          },
          field_mapping: Bulkrax.field_mappings['Bulkrax::MarcXmlParser']
        )
      end
      let(:object_factory) { instance_double(ObjectFactory) }

      before do
        marc_xml_entry.raw_metadata = raw_metadata
        allow(ObjectFactory).to receive(:new).and_return(object_factory)
        allow(object_factory).to receive(:run).and_return(instance_of(Work))
        allow(User).to receive(:batch_user)
      end

      context 'without a parent' do
        it 'succeeds' do
          marc_xml_entry.build
          expect(marc_xml_entry.status).to eq('succeeded')
        end

        it 'builds entry using local_processing overrides and matchers' do
          marc_xml_entry.build
          expect(marc_xml_entry.parsed_metadata).to eq(
            'abstract' => ["In A Drive in the Coach through the Streets of London, a young girl named Julia is \"granted the privilege of shopping with her mother only if she will \"behave wisely in the streets\" and \"not give [her] mind to self-pleasing.\" Of course, she cannot keep this promise and she eagerly peeks in at every store window and begs her mother to buy her everything she sees. Her mother therefore allows her to select one item from every shop. Julia, ecstatic, chooses, among other things, blue satin boots, a penknife, and a new hat with flowers, until the pair reach the undertakers shop. There her mood droops considerably and she realizes the moral of the lesson, recited by her mother, as she picks out a coffin: \"but she that liveth in pleasure is dead while she liveth\" (1 Timothy 5:6).\" --https://en.wikipedia.org/wiki/Mary_Martha_Sherwood (accessed 29/09/2020).          Abstract part 2"],
            'admin_set_id' => "admin_set/default",
            'alternative_title' => ["A coach ride around London for young ladies", "Julias coach ride around London", "A coach drive for Julia and a lesson learned"],
            'arrangement' => [],
            'bibliography' => ["Every day with Jesus / A. Man -- Hope for hard times / A.N. Other -- How to pray / A. Woman -- Devotions for girls / A.N. Otherwoman."],
            'biographical_note' => ["\"Mary Martha Sherwood (née Butt; 6 May 1775 {u2013} 22 September 1851) was a writer of childrens literature in 19th-century Britain. She composed over 400 books, tracts, magazine articles, and chapbooks. Among her best known works are The History of Little Henry and his Bearer (1814), The History of Henry Milner (1822{u2013}37), and The History of the Fairchild Family (1818{u2013}47). While Sherwood is known primarily for the strong evangelicalism that coloured her early writings, her later works are characterized by common Victorian themes, such as domesticity. Sherwoods childhood was uneventful, although she recalled it as the happiest part of her life. After she married Captain Henry Sherwood and moved to India, she converted to evangelical Christianity and began to write for children. Although her books were initially intended only for the children of the military encampments in India, the British public also received them enthusiastically. The Sherwoods returned to England after a decade in India and, building upon her popularity, Sherwood opened a boarding school and published scores of texts for children and the poor. Many of Sherwoods books were bestsellers and she has been described as \"one of the most significant authors of childrens literature of the nineteenth century\".[1] Her depictions of domesticity and Britains relationship with India may have played a part in shaping the opinions of many young British readers.[2] However, her works fell from favor as a different style of childrens literature came into fashion during the late nineteenth century, one exemplified by Lewis Carrolls playful and nonsensical Alices Adventures in Wonderland.\" See the full Wikipedia entry at https://en.wikipedia.org/wiki/Mary_Martha_Sherwood"],
            'collection_title' => [],
            'collections' => [],
            'contributor' => ["Pollard, M. (Mary), Former owner", "Woods, Margaret W., active 1850, Former owner", "Pollard Collection, Former owner", "F. Houlston and Son, Printer", "Bank of America, Sponsor"],
            'creator' => ["Sherwood, Mrs. (Mary Martha), 1775-1851, Author"],
            'creator_loc' => ["Sherwood, Mrs. (Mary Martha), 1775-1851, Author", "Pollard, M. (Mary), Former owner", "Woods, Margaret W., active 1850, Former owner", "Pollard Collection, Former owner", "F. Houlston and Son, Printer"],
            'creator_local' => ["Bank of America, Sponsor"],
            'date_created' => ["1823.", "2021"],
            'description' => ["In A Drive in the Coach through the Streets of London, a young girl named Julia is \"granted the privilege of shopping with her mother only if she will \"behave wisely in the streets\" and \"not give [her]..."],
            'digital_object_identifier' => ["digital obj id"],
            'digital_root_number' => ["MS4053"],
            'dris_unique' => ["Jmarc0713"],
            'file' => [],
            'finding_aid' => ['More for archival/MSS collections, but map anyway https://en.wikipedia.org/wiki/Mary_Martha_Sherwood2222'],
            'folder_number' => ['901'],
            'genre' => ["Books. : lctgm", "pamphlets. : aat"],
            'genre_aat' => ["pamphlets. : aat"],
            'genre_tgm' => ["Books. : lctgm"],
            'identifier' => ["OLS POL 3811 no.3.","2222 OLS POL 3811 no.3."],
            'image_range' => ["001:009"],
            'issued_with' => ["With a separately titled map on an accompanying sheet: Lady Lucys route around Covent Garden."],
            'keyword' => ["with $2 Sherwood, Mrs. (Mary Martha), 1775-1851.", "with $2 F. Houlston and Son.", "with $2 Sherwood family."],
            'language' => ["English", "French"],
            'location' => ["Department of Early Printed Books,", "2222 Department of Early Printed Books,"],
            'medium' => ["ink"],
            'note' => ["THIS IS A DUMMY RECORD (INACCURATE); TESTING PURPOSES ONLY.", "English, with parallel French translation."],
            'physical_extent' => ["v, 45 pages, 6 unnumbered leaves of plates : 25 cm. + 1 folded colour map (24 x 37 cm.)"],
            'provenance' => ["With MS name and date on title page: Margaret W. Woods, 1850. Formerly owned by Mary Paul Pollard, and forms part of the Pollard Collection of childrens books. test u", "ind1."],
            'publisher' => ["printed by and for F. Houlston and Son,", "printed by and for TCD"],
            'publisher_location' => ["Wellington, Salop [Shropshire] :", "Trinity College Dublin:"],
            'related_url' => ["https://en.wikipedia.org/wiki/Mary_Martha_Sherwood", "https://en.wikipedia.org/wiki/Mary_Martha_Sherwood2222"],
            'resource_type' => ["text", "still image", "cartographic image"],
            'rights_statement' => ['Copyright The Board of Trinity College Dublin. Images are available for single-use academic application only. Publication, transmission or display is prohibited without formal written approval of the Library of Trinity College, Dublin.'],
            'series_title' => ["Miss Primroses library for young ladies ; no. 6."],
            'source' => ["Jmarc0713"],
            'sponsor' => ["Digitisation and metadata creation sponsored by the Bank of America, 2018.", "TCD"],
            'sub_fond' => [],
            'subject' => ["Sherwood, Mrs. (Mary Martha), 1775-1851.", "F. Houlston and Son.", "Sherwood family.", "Avarice Religious aspectsChristianity Juvenile fiction.", "Worldliness Juvenile fiction.", "Christian life Juvenile fiction.", "Mothers and daughters Juvenile fiction.", "Conduct of life Juvenile fiction.", "Avarice Religious aspectsChristianity.", "Worldliness.", "Christian life.", "Mothers and daughters.", "Young women Conduct of life."],
            'support' => ["paper (fiber product)", "ink2"],
            'title' => ["A drive in the coach through the streets of London :a story founded on fact "],
            'visibility' => 'open'
          )
        end
      end

      context 'with a parent collection' do
        let(:parent) { Collection.create(title: ['Test Collection'], collection_type_gid: Hyrax::CollectionType.find_or_create_default_collection_type.gid).id }

        it 'adds the collection to parsed_metadata' do
          #byebug
          marc_xml_entry.build
          expect(marc_xml_entry.parsed_metadata['collections']).to eq([{ 'id' => parent }])
        end
      end

      context 'with a parent work' do
        let(:parent) { Work.create(title: ['Test Work']).id }

        it 'does not add the work id into parsed_metadata' do
          marc_xml_entry.build
          expect(marc_xml_entry.parsed_metadata['collections']).to eq([])
        end
      end

      context 'with LO files' do
        let(:image_type) { 'LO' }
        let(:path) { './spec/fixtures/MARC to XML for HYRAX testing.xml' }
        let(:data) { described_class.read_data(path) }

        before do
          allow(marc_xml_entry).to receive(:image_base_path).and_return('./spec/fixtures')
        end

        it 'adds an array of only LO files' do
          marc_xml_entry.build
          expect(marc_xml_entry.parsed_metadata['file']).to eq(
            ['./spec/fixtures/901/LO/MS4053_001_LO.jpg',
             './spec/fixtures/901/LO/MS4053_002_LO.jpg',
             './spec/fixtures/901/LO/MS4053_003_LO.jpg',
             './spec/fixtures/901/LO/MS4053_004_LO.jpg',
             './spec/fixtures/901/LO/MS4053_005_LO.jpg',
             './spec/fixtures/901/LO/MS4053_006_LO.jpg',
             './spec/fixtures/901/LO/MS4053_007_LO.jpg',
             './spec/fixtures/901/LO/MS4053_008_LO.jpg',
             './spec/fixtures/901/LO/MS4053_009_LO.jpg']
          )
        end
      end
    end
  end
end

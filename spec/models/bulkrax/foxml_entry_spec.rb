# frozen_string_literal: true

require 'rails_helper'

module Bulkrax
  RSpec.describe FoxmlEntry, type: :model do
    let(:path) { './spec/fixtures/Named Collection Example_NAMED COLLECTION RECORD v3.6_20181207.xml' }
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
            source_identifier: '0145515',
            data: "<!-- This grammar has been deprecated - use FMPXMLRESULT instead --><FMPDSORESULT><ERRORCODE>0</ERRORCODE><DATABASE>DRIS-catalogue v3.6.fmp12</DATABASE><LAYOUT></LAYOUT><ROW MODID=\"4\" RECORDID=\"148143\"><TitleLargerEntity></TitleLargerEntity><Abstract>The correspondence of John and Catherine D'Alton is a collection of personal correspondence of some 275 letters sent between John and his wife Catherine from 1818 to 1853. John D’Alton was educated at Trinity College Dublin and was an antiquarian, barrister, Irish historian, genealogist, and biographer.The collection was donated to the Library of Trinity College, Dublin by Father Wallace Clare, St. Joseph’s College, Ipswich, Suffolk, on the 8th of  December 1951.</Abstract><Bibliography></Bibliography><CALM></CALM><CatNo></CatNo><Citation>IE TCD MS 2327/64 ; IE TCD MS 2327/87</Citation><CopyrightNotice>Copyright 2017 The Board of Trinity College Dublin. Images are available for single-use academic application only. Publication, transmission or display is prohibited without formal written approval of Trinity College Library, Dublin.</CopyrightNotice><Description></Description><DrisDocumentNo>_folio _ </DrisDocumentNo><DrisPageNo>folio _ </DrisPageNo><DRISPhotoID>_0</DRISPhotoID><DrisUnique>0145515</DrisUnique><Europeana>No</Europeana><FormatDur></FormatDur><FormatH></FormatH><FormatResolution></FormatResolution><FormatW></FormatW><Image>No</Image><Introduction></Introduction><LCN></LCN><MetadataCreationDate>23/10/2018 10:10:33</MetadataCreationDate><MetadataModificationDate>07/12/2018 08:18:48</MetadataModificationDate><PageNo></PageNo><PageNoB></PageNoB><PageTotal>1</PageTotal><PageType>folio</PageType><PageTypeB></PageTypeB><ProjectName></ProjectName><ProjectNo></ProjectNo><Provenance></Provenance><Publisher></Publisher><PublisherCity></PublisherCity><PublisherCountry></PublisherCountry><Sponsor></Sponsor><Title>Correspondence of John and Catherine D'Alton</Title><TitleLargerEntity2></TitleLargerEntity2><TOC></TOC><Type>text</Type><TypeOfWork>collections (object groupings)</TypeOfWork><Visibility>COLLECTION/OBJECT</Visibility><AttributedArtist><DATA>D’Alton, John, 1792-1867</DATA><DATA>D’Alton, John, 1792-1867</DATA></AttributedArtist><AttributedArtistCalculation><DATA>AttributedArtistRole: Author;AttributedArtistRoleCode: aut; Attributed Artist: D’Alton, John, 1792-1867</DATA><DATA>AttributedArtistRole: Addressee;AttributedArtistRoleCode: rcp; Attributed Artist: D’Alton, John, 1792-1867</DATA></AttributedArtistCalculation><AttributedArtistRole><DATA>Author</DATA><DATA>Addressee</DATA></AttributedArtistRole><AttributedArtistRoleCode><DATA>aut</DATA><DATA>rcp</DATA></AttributedArtistRoleCode><CopyrightHolder><DATA>Public domain</DATA></CopyrightHolder><CopyrightNotes><DATA></DATA></CopyrightNotes><CopyrightStatus><DATA>Expired</DATA></CopyrightStatus><SourceMaterialCopyrightStatusCalculation><DATA>CopyrightStatus: Expired; CopyrightHolder: Public domain; CopyrightNotes: </DATA></SourceMaterialCopyrightStatusCalculation><Culture><DATA>Irish</DATA></Culture><DateCalculation><DATA>DateType: start; Day: --1818 A.D.</DATA><DATA>DateType: end; Day: --1853 A.D.</DATA></DateCalculation><Dateday><DATA></DATA><DATA></DATA></Dateday><DateMonth><DATA></DATA><DATA></DATA></DateMonth><DateType><DATA>start</DATA><DATA>end</DATA></DateType><DateYear><DATA>1818</DATA><DATA>1853</DATA></DateYear><Era><DATA>A.D.</DATA><DATA>A.D.</DATA></Era><ISOCalculation><DATA>start 1818</DATA><DATA>end 1853</DATA></ISOCalculation><Language><DATA>English</DATA></Language><LanguageCalculation><DATA>Language: English; LanguageCode: eng</DATA></LanguageCalculation><LanguageTermCode><DATA>eng</DATA></LanguageTermCode><LCSubjectNames><DATA>D’Alton, John, 1792-1867--Correspondence</DATA></LCSubjectNames><Location><DATA>Manuscripts &amp; Archives Research Library, Trinity College Dublin</DATA></Location><LocationClaculation><DATA>LocationType: repository; Location: Manuscripts &amp; Archives Research Library, Trinity College Dublin</DATA></LocationClaculation><LocationType><DATA>repository</DATA></LocationType><Medium><DATA>paper (fiber product)</DATA></Medium><OpenKeyword><DATA>D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence</DATA></OpenKeyword><OtherArtist><DATA>D’Alton, Catherine (Kate), approximately 1795-1859</DATA><DATA>D’Alton, Catherine (Kate), approximately 1795-1859</DATA></OtherArtist><OtherArtistCalculation><DATA>OtherArtistRole: Author; OtherArtistRoleCode: aut; OtherArtist: D’Alton, Catherine (Kate), approximately 1795-1859</DATA><DATA>OtherArtistRole: Addressee; OtherArtistRoleCode: rcp; OtherArtist: D’Alton, Catherine (Kate), approximately 1795-1859</DATA></OtherArtistCalculation><OtherArtistRole><DATA>Author</DATA><DATA>Addressee</DATA></OtherArtistRole><OtherArtistRoleCode><DATA>aut</DATA><DATA>rcp</DATA></OtherArtistRoleCode><OtherTitle></OtherTitle><RelatedItemCalculation><DATA>RelatedItemType: constituent; RelatedItemIdentifier: 0145514; RelatedItemTitle: Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton</DATA><DATA>RelatedItemType: constituent; RelatedItemIdentifier: 0145521; RelatedItemTitle: Letter from John D’Alton, Mullingar, September 1819 to Catherine (Kate) D’Alton</DATA></RelatedItemCalculation><RelatedItemIdentifier><DATA>0145514</DATA><DATA>0145521</DATA></RelatedItemIdentifier><RelatedItemTitle><DATA>Letter from Catherine (Kate) D’Alton, Clonmore, 8th-12th August, 1824 to John D’Alton</DATA><DATA>Letter from John D’Alton, Mullingar, September 1819 to Catherine (Kate) D’Alton</DATA></RelatedItemTitle><RelatedItemType><DATA>constituent</DATA><DATA>constituent</DATA></RelatedItemType><SeriesReportNo></SeriesReportNo><SubjectLCSH></SubjectLCSH><SubjectTMG><DATA>Correspondence</DATA><DATA>Manuscripts</DATA></SubjectTMG><Support><DATA>ink</DATA></Support></ROW></FMPDSORESULT>",
            collection: [],
            file: [],
            children: []
          )
        end
      end
    end

    describe '#build' do
      subject(:foxml_entry) { described_class.new(importerexporter: importer) }
      let(:parent) { nil }
      let(:image_type) { 'Not Now' }
      let(:raw_metadata) { described_class.data_for_entry(data) }
      let(:importer) do
        Bulkrax::Importer.new(
          name: 'Importer',
          admin_set_id: AdminSet::DEFAULT_ID,
          parser_klass: 'Bulkrax::FoxmlParser',
          parser_fields: {
            'import_file_path' => path,
            object_type: 'Work',
            import_type: 'single',
            image_type: image_type,
            parent_id: parent
          },
          field_mapping: Bulkrax.field_mappings['Bulkrax::FoxmlParser']
        )
      end
      let(:object_factory) { instance_double(ObjectFactory) }

      before do
        foxml_entry.raw_metadata = raw_metadata
        allow(ObjectFactory).to receive(:new).and_return(object_factory)
        allow(object_factory).to receive(:run).and_return(instance_of(Work))
        allow(User).to receive(:batch_user)
      end

      context 'without a parent' do
        it 'succeeds' do
          foxml_entry.build
          expect(foxml_entry.status).to eq('succeeded')
        end

        it 'builds entry using local_processing overrides and matchers' do
          foxml_entry.build
          expect(foxml_entry.parsed_metadata).to eq(
            'abstract' => ["The correspondence of John and Catherine D'Alton is a collection of personal correspondence of some 275 letters sent between John and his wife Catherine from 1818 to 1853. John D’Alton was educated at Trinity College Dublin and was an antiquarian, barrister, Irish historian, genealogist, and biographer.The collection was donated to the Library of Trinity College, Dublin by Father Wallace Clare, St. Joseph’s College, Ipswich, Suffolk, on the 8th of  December 1951."],
            'collections' => [],
            'contributor' => ['D’Alton, John, 1792-1867, Addressee', 'D’Alton, Catherine (Kate), approximately 1795-1859, Addressee'],
            'copyright_status' => ['Public domain'],
            'creator' => ['D’Alton, John, 1792-1867, Author', 'D’Alton, Catherine (Kate), approximately 1795-1859, Author'],
            'creator_loc' => ['D’Alton, John, 1792-1867', 'D’Alton, John, 1792-1867'],
            'creator_local' => ['D’Alton, Catherine (Kate), approximately 1795-1859', 'D’Alton, Catherine (Kate), approximately 1795-1859'],
            'culture' => ['Irish'],
            'date_created' => ['start 1818', 'end 1853'],
            'description' => ["The correspondence of John and Catherine D'Alton is a collection of personal correspondence of some 275 letters sent between John and his wife Catherine from 1818 to 1853. John D’Alton was educated at ..."],
            'digital_object_identifier' => ['_0'],
            'dris_document_no' => ['_folio _'],
            'dris_page_no' => ['folio _'],
            'dris_unique' => ['0145515'],
            'file' => [],
            'genre' => ['Correspondence', 'Manuscripts', 'collections (object groupings)'],
            'genre_aat' => ['collections (object groupings)'],
            'genre_tgm' => %w[Correspondence Manuscripts],
            'identifier' => ['IE TCD MS 2327/64 ; IE TCD MS 2327/87'],
            'keyword' => ['D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence'],
            'language' => ['English'],
            'location' => ['Manuscripts & Archives Research Library, Trinity College Dublin'],
            'location_type' => ['repository'],
            'medium' => ['ink'],
            'page_type' => ['folio'],
            'resource_type' => ['text'],
            'rights_statement' => ['Copyright The Board of Trinity College Dublin. Images are available for single-use academic application only. Publication, transmission or display is prohibited without formal written approval of the Library of Trinity College, Dublin.'],
            'source' => ['0145515'],
            'subject' => ['D’Alton, John, 1792-1867--Correspondence'],
            'subject_local_keyword' => ['D’Alton, Catherine (Kate), approximately 1795-1859--Correspondence'],
            'subject_subj_name' => ['D’Alton, John, 1792-1867--Correspondence'],
            'support' => ['paper (fiber product)'],
            'title' => ["Correspondence of John and Catherine D'Alton"],
            'total_records' => ['1'],
            'visibility' => 'open'
          )
        end
      end

      context 'with a parent collection' do
        let(:parent) { Collection.create(title: ['Test Collection'], collection_type_gid: Hyrax::CollectionType.find_or_create_default_collection_type.gid).id }

        it 'adds the collection to parsed_metadata' do
          foxml_entry.build
          expect(foxml_entry.parsed_metadata['collections']).to eq([{ 'id' => parent }])
        end
      end

      context 'with a parent work' do
        let(:parent) { Work.create(title: ['Test Work']).id }

        it 'does not add the work id into parsed_metadata' do
          foxml_entry.build
          expect(foxml_entry.parsed_metadata['collections']).to eq([])
        end
      end

      context 'with LO files' do
        let(:image_type) { 'LO' }
        let(:path) { './spec/fixtures/Named Collection Example_PARTS_ONE_OBJECT.XML' }
        let(:data) { described_class.read_data(path) }

        before do
          allow(foxml_entry).to receive(:image_base_path).and_return('./spec/fixtures')
        end

        it 'adds an array of only LO files' do
          foxml_entry.build
          expect(foxml_entry.parsed_metadata['file']).to eq(
            ['./spec/fixtures/1822/LO/MS2327-64_0_LO.jpg',
             './spec/fixtures/1822/LO/MS2327-64_1_LO.jpg',
             './spec/fixtures/1822/LO/MS2327-64_2_LO.jpg',
             './spec/fixtures/1822/LO/MS2327-64_3_LO.jpg',
             './spec/fixtures/1822/LO/MS2327-64_4_LO.jpg']
          )
        end
      end
    end
  end
end

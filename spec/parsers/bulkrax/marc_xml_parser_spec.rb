# frozen_string_literal: true

require 'rails_helper'

module Bulkrax
  RSpec.describe MarcXmlParser do
    subject(:marc_xml_parser) { described_class.new(importer) }
    let(:path) { './spec/fixtures/MARC to XML for HYRAX testing.xml' }
    let(:parent) { nil }
    let(:image_type) { 'Not Now' }
    let(:import_type) { 'single' }
    let(:object_type) { 'Work' }

    before do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
      ActiveFedora::Cleaner.clean!
    end


    let(:importer) do
      Bulkrax::Importer.create(
        name: 'Importer',
        admin_set_id: AdminSet::DEFAULT_ID,
        user_id: User.batch_user.id,
        parser_klass: 'Bulkrax::MarcXmlParser',
        parser_fields: {
          import_file_path: path,
          object_type: object_type,
          import_type: import_type,
          image_type: image_type,
          parent_id: parent
        },
        field_mapping: Bulkrax.field_mappings['Bulkrax::MarcXmlParser']
      )
    end
    let(:entry) do
      Bulkrax::MarcXmlEntry.create(
        importerexporter: importer
      )
    end
    let(:collection_entry) do
      Bulkrax::MarcXmlCollectionEntry.create(
        importerexporter: importer
      )
    end

    # Returns unless we have a parent
    # Creates a collection entry for the parent
    describe '#create_collections' do
      context 'No parent specified' do
        it 'nothing happens' do
          expect(marc_xml_parser).not_to receive(:increment_counters)
          marc_xml_parser.create_collections
        end
      end
      context 'Parent specified' do
        let(:parent) { Collection.create(title: ['Test Collection'], collection_type_gid: Hyrax::CollectionType.find_or_create_default_collection_type.gid).id }

        it 'collection entry is created' do
          expect(marc_xml_parser).to receive(:increment_counters).once
          marc_xml_parser.create_collections
        end

        it 'parent source is set to id' do
          marc_xml_parser.create_collections
          expect(marc_xml_parser.parent.send(Bulkrax.system_identifier_field)).to eq([parent])
        end
      end
    end

    describe '#create_works' do
      context 'import_type set to single' do
        it 'processes the records' do
          expect(marc_xml_parser).to receive(:increment_counters).once
          marc_xml_parser.create_works
        end
      end

      context 'import_type set to multiple' do
        let(:path) { './spec/fixtures/MARC to XML for HYRAX testing.xml' }
        let(:import_type) { 'multiple' }

        it 'processes the records' do
          expect(marc_xml_parser).to receive(:increment_counters).once
          marc_xml_parser.create_works
        end
      end
    end

    # Returns unless we have a parent work
    # Builds the correct array of entries and passes to the job
    describe '#create_parent_child_relationships' do
      let(:parent) { Work.create(title: ['Test Collection']).id }

      context 'parent is a Work' do
        before do
          marc_xml_parser.create_collections
          allow(marc_xml_parser.importerexporter).to receive(:entries).and_return([collection_entry, entry])
        end

        it 'calls ChildRelationshipsJob with the correct parent and child' do
          expect(Bulkrax::ChildRelationshipsJob).to receive(:perform_later).with(collection_entry.id, [entry.id], 1)
          marc_xml_parser.create_parent_child_relationships
        end
      end

      context 'no parent' do
        let(:parent) { nil }

        it 'does not call ChildRelationshipsJob' do
          expect(Bulkrax::ChildRelationshipsJob).not_to receive(:perform_later)
          marc_xml_parser.create_parent_child_relationships
        end
      end
    end
  end
end

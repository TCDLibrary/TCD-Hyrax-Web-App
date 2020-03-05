# frozen_string_literal: true

require 'rails_helper'

module Bulkrax
  RSpec.describe FoxmlParser do
    subject(:foxml_parser) { described_class.new(importer) }
    let(:path) { './spec/fixtures/Named Collection Example_NAMED COLLECTION RECORD v3.6_20181207.xml' }
    let(:parent) { nil }
    let(:image_type) { 'Not Now' }
    let(:import_type) { 'single' }
    let(:object_type) { 'Work' }
    let(:importer) do
      Bulkrax::Importer.create(
        name: 'Importer',
        admin_set_id: AdminSet::DEFAULT_ID,
        user_id: User.batch_user.id,
        parser_klass: 'Bulkrax::FoxmlParser',
        parser_fields: {
          import_file_path: path,
          object_type: object_type,
          import_type: import_type,
          image_type: image_type,
          parent_id: parent
        },
        field_mapping: Bulkrax.field_mappings['Bulkrax::FoxmlParser']
      )
    end
    let(:entry) do
      Bulkrax::FoxmlEntry.create(
        importerexporter: importer
      )
    end
    let(:collection_entry) do
      Bulkrax::FoxmlCollectionEntry.create(
        importerexporter: importer
      )
    end

    # Returns unless we have a parent
    # Creates a collection entry for the parent
    describe '#create_collections' do
      context 'No parent specified' do
        it 'nothing happens' do
          expect(foxml_parser).not_to receive(:increment_counters)
          foxml_parser.create_collections
        end
      end
      context 'Parent specified' do
        let(:parent) { Collection.create(title: ['Test Collection'], collection_type_gid: Hyrax::CollectionType.find_or_create_default_collection_type.gid).id }

        it 'collection entry is created' do
          expect(foxml_parser).to receive(:increment_counters).once
          foxml_parser.create_collections
        end

        it 'parent source is set to id' do
          foxml_parser.create_collections
          expect(foxml_parser.parent.send(Bulkrax.system_identifier_field)).to eq([parent])
        end
      end
    end

    describe '#create_works' do
      context 'import_type set to single' do
        it 'processes the records' do
          expect(foxml_parser).to receive(:increment_counters).once
          foxml_parser.create_works
        end
      end

      context 'import_type set to multiple' do
        let(:path) { './spec/fixtures/Named_Collection_Example_PARTS_RECORDS_v3.6_20181207.xml' }
        let(:import_type) { 'multiple' }

        it 'processes the records' do
          expect(foxml_parser).to receive(:increment_counters).once
          foxml_parser.create_works
        end
      end
    end

    # Returns unless we have a parent work
    # Builds the correct array of entries and passes to the job
    describe '#create_parent_child_relationships' do
      let(:parent) { Work.create(title: ['Test Collection']).id }

      context 'parent is a Work' do
        before do
          foxml_parser.create_collections
          allow(foxml_parser.importerexporter).to receive(:entries).and_return([collection_entry, entry])
        end

        it 'calls ChildRelationshipsJob with the correct parent and child' do
          expect(Bulkrax::ChildRelationshipsJob).to receive(:perform_later).with(collection_entry.id, [entry.id], 1)
          foxml_parser.create_parent_child_relationships
        end
      end
    end
  end
end

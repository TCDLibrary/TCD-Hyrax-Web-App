class CreateHyraxChecksums < ActiveRecord::Migration[5.1]
  def up
    create_table :hyrax_checksums, :id => false do |t|
      t.string  :fileset_id, :null => false
      t.date    :ingest_date
      t.integer :ingest_week_no
      t.date    :last_fixity_check
      t.string  :last_fixity_result

      t.timestamps
    end
    add_index :hyrax_checksums, :fileset_id, unique: true
    add_index :hyrax_checksums, :ingest_week_no
  end

  def down
    drop_table :hyrax_checksums
  end
end

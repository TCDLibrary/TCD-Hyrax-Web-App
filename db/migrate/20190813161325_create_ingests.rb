class CreateIngests < ActiveRecord::Migration[5.1]
  def up
    create_table :ingests do |t|
      t.string "object_model_type", :default => '', :null => false  # "Single Object, Multiple Images", "Multiple Objects, One Image Each"
      t.string "xml_file_name", :default => '', :null => false      # location should be public/data/ingest
      t.string "new_work_type", :default => '', :null => false      # Work, Folio, Subseries
      t.string "parent_type", :default => '', :null => false        # Collection, Work, Folio, Subseries, No Parent
      t.string "parent_id", :default => '', :null => false          # Optional
      t.string "image_type", :default => '', :null => false         # Not Now, LO, HI, TIFF
      t.string "submitted_by", :default => '', :null => false
      t.timestamps                                  # created_at, updated_at
    end
  end

  def down
    drop_table :ingests
  end
end

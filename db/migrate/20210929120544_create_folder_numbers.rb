class CreateFolderNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :folder_numbers do |t|
      t.integer :project_id
      t.string :root_filename
      t.string :title
      t.string :job_type
      t.string :suitable_for_ingest
      t.string :status
      t.text :note
      t.string :created_by

      t.timestamps
    end
  end
end

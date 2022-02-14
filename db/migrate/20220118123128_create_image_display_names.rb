class CreateImageDisplayNames < ActiveRecord::Migration[5.1]
  def change
    create_table :image_display_names do |t|
      t.string :object_id,  :null => false
      t.string :image_file_name,  :null => false
      t.string :image_display_text,  :null => false

      t.timestamps
    end
  end
end

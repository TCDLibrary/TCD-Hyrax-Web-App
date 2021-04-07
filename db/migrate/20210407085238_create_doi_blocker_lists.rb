class CreateDoiBlockerLists < ActiveRecord::Migration[5.1]
  def change
    create_table :doi_blocker_lists do |t|
      t.string :object_id
      t.text :description

      t.timestamps
    end
  end
end

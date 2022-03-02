class CreateRecentDois < ActiveRecord::Migration[5.1]
  def change
    create_table :recent_dois do |t|
      t.string :dris_unique
      t.string :doi
      t.timestamps
    end
  end
end

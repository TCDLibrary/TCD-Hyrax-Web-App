class AddVisibilityToIngests < ActiveRecord::Migration[5.1]
  def change
    add_column :ingests, :visibility, :string
  end
end

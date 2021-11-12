class AddProjectNameToFolderNumbers < ActiveRecord::Migration[5.1]
  def change
    add_column :folder_numbers, :project_name, :string
  end
end

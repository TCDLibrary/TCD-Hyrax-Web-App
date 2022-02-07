class AddImageNameToHyraxChecksums < ActiveRecord::Migration[5.1]
  def change
    add_column :hyrax_checksums, :image_file_name, :string
  end
end

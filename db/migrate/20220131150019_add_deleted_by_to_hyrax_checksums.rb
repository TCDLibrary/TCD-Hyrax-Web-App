class AddDeletedByToHyraxChecksums < ActiveRecord::Migration[5.1]
  def change
    add_column :hyrax_checksums, :deleted_by, :string
  end
end

class AddImageToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :image, :string
    add_reference :patients, :image_editor, foreign_key: { to_table: :nurses }
    add_column :patients, :image_updated_at, :datetime
  end
end

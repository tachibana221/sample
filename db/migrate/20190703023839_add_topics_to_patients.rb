class AddTopicsToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :topics, :text
    add_reference :patients, :topics_editor, foreign_key: { to_table: :nurses }
    add_column :patients, :topics_updated_at, :datetime
  end
end

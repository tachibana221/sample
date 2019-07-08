class CreateBedsoreParts < ActiveRecord::Migration[5.2]
  def change
    create_table :bedsore_parts do |t|
      t.integer :part_genre
      t.string :part_name
      t.integer :common_part
      t.references :patient, foreign_key: true
      t.references :nurse, foreign_key: true

      t.timestamps
    end
  end
end

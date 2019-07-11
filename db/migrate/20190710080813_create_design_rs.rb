class CreateDesignRs < ActiveRecord::Migration[5.2]
  def change
    create_table :design_rs do |t|
      t.integer :depth
      t.decimal :size_minor_axis
      t.decimal :size_major_axis
      t.integer :inflammation
      t.integer :granule_tissue
      t.integer :necrotic_tissue
      t.decimal :pocket_minor_axis
      t.decimal :pocket_major_axis
      t.references :bedsore, foreign_key: true

      t.timestamps
    end
  end
end

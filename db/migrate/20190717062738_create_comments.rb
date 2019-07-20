class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :position_x
      t.integer :position_y
      t.references :bedsore, foreign_key: true

      t.timestamps
    end
  end
end

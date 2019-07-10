class CreateBedsores < ActiveRecord::Migration[5.2]
  def change
    create_table :bedsores do |t|
      t.string :image
      t.datetime :image_edited_at
      t.text :comment
      t.string :handwrite_image
      t.references :bedsore_part, foreign_key: true
      t.references :nurse, foreign_key: true

      t.timestamps
    end
  end
end

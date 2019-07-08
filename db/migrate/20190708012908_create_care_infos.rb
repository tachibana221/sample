class CreateCareInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :care_infos do |t|
      t.string :image
      t.datetime :image_edited_at
      t.references :image_editor, foreign_key: { to_table: :nurses }
      t.text :comment
      t.datetime :comment_edited_at
      t.references :comment_editor, foreign_key: { to_table: :nurses }
      t.references :nurse, foreign_key: true

      t.timestamps
    end
  end
end

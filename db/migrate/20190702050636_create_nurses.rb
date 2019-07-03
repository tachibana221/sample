class CreateNurses < ActiveRecord::Migration[5.2]
  def change
    create_table :nurses do |t|
      t.string :name
      t.string :name_kana
      t.string :password_digest

      t.timestamps
    end
  end
end

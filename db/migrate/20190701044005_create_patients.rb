class CreatePatients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :name_kana
      t.integer :age
      t.integer :sex

      t.timestamps
    end
  end
end

class CreateCareTools < ActiveRecord::Migration[5.2]
  def change
    create_table :care_tools do |t|
      t.string :name
      t.integer :genre

      t.timestamps
    end
  end
end

class CreateUsingDepressureTools < ActiveRecord::Migration[5.2]
  def change
    create_table :using_depressure_tools do |t|
      t.text :comment
      t.string :image
      t.references :patient, foreign_key: true

      t.timestamps
    end
  end
end

class CreateDepressureTools < ActiveRecord::Migration[5.2]
  def change
    create_table :depressure_tools do |t|
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end

class CreateAssignDepressureTools < ActiveRecord::Migration[5.2]
  def change
    create_table :assign_depressure_tools do |t|
      t.references :using_depressure_tool, foreign_key: true
      t.references :depressure_tool, foreign_key: true

      t.timestamps
    end
  end
end

class CreateAssignCareTools < ActiveRecord::Migration[5.2]
  def change
    create_table :assign_care_tools do |t|
      t.references :using_care_tool, foreign_key: true
      t.references :care_tool, foreign_key: true

      t.timestamps
    end
  end
end

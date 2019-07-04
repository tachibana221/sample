class RenameTypeColumnToDepressureTools < ActiveRecord::Migration[5.2]
  def change
    rename_column :depressure_tools, :type, :genre
  end
end

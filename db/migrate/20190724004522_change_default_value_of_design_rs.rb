class ChangeDefaultValueOfDesignRs < ActiveRecord::Migration[5.2]
  def change
    change_column :design_rs, :depth, :integer, :default => 0
    change_column :design_rs, :exudate, :integer, :default => 0
    change_column :design_rs, :size_minor_axis, :decimal, :default => 0
    change_column :design_rs, :size_major_axis, :decimal, :default => 0
    change_column :design_rs, :inflammation, :integer, :default => 0
    change_column :design_rs, :granule_tissue, :integer, :default => 0
    change_column :design_rs, :necrotic_tissue, :integer, :default => 0
    change_column :design_rs, :pocket_minor_axis, :decimal, :default => 0
    change_column :design_rs, :pocket_major_axis, :decimal, :default => 0
  end
end

class ChangeScaleOfDesignRs < ActiveRecord::Migration[5.2]
  def change
    change_column :design_rs, :size_minor_axis, :decimal, :default => 0, :precision => 6, :scale => 1
    change_column :design_rs, :size_major_axis, :decimal, :default => 0, :precision => 6, :scale => 1
    change_column :design_rs, :pocket_minor_axis, :decimal, :default => 0, :precision => 6, :scale => 1
    change_column :design_rs, :pocket_major_axis, :decimal, :default => 0, :precision => 6, :scale => 1
  end
end

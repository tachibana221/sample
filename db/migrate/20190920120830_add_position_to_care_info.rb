class AddPositionToCareInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :care_infos, :position, :integer
    CareInfo.order(:updated_at).each.with_index(1) do |care_info, index|
      care_info.update_column :position, index
    end
    CareInfo.reset_column_information
  end
end

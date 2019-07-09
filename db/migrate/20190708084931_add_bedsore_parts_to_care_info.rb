class AddBedsorePartsToCareInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :care_infos, :bedsore_part, foreign_key: true
  end
end

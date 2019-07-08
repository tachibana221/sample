class BedsorePart < ApplicationRecord
  belongs_to :patient
  belongs_to :nurse, optional: true

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    self.part_genre = params[:part_genre]
    self.part_name = params[:part_name]
    self.common_part = params[:common_part]
    self.nurse = nurse
  end
end

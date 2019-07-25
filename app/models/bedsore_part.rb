# 褥瘡部位
class BedsorePart < ApplicationRecord
  belongs_to :patient
  belongs_to :nurse, optional: true

  has_many :care_infos, dependent: :destroy
  has_many :bedsores, dependent: :destroy

  # 大分類
  enum part_genre: { "未入力": 0, "頭部": 1, "胸部": 2, "腰部": 3, "右腕部": 4, "左腕部": 5, "右脚部": 6, "左足部": 7 }, _prefix: true

  # 好発部位
  enum common_part: { "未入力": 0, "後頭部": 1, "耳介部": 2, "頬骨部": 3, "胸部": 4, "胸部側面(右)": 5, "胸部側面(右)": 6, "仙骨部": 7, "大転子部(右)": 8, "大転子部(左)": 9, "陰部": 10, "肩峰部": 11, "肩甲骨部": 12, "肘関節部": 13, "肩峰部": 14, "肩甲骨部": 15, "肘関節部": 16, "膝正面": 17, "膝の内側顆": 18, "膝の外側顆": 19, "外果部": 20, "足指": 21, "膝正面": 22, "膝の内側顆": 23, "膝の外側顆": 24, "外果部": 25, "足指": 26 }, _prefix: true

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    self.part_genre = params[:part_genre]
    self.part_name = params[:part_name]
    self.common_part = params[:common_part]
    self.nurse = nurse
  end
end

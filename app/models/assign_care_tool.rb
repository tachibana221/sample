# ケア物品と使用ケア物品を紐付けるための中間テーブル
class AssignCareTool < ApplicationRecord
  belongs_to :using_care_tool
  belongs_to :care_tool
end

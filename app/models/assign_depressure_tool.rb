# 除圧器具と使用除圧器具を紐付けるための中間テーブル
class AssignDepressureTool < ApplicationRecord
  belongs_to :using_depressure_tool
  belongs_to :depressure_tool
end

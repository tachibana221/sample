class UsingDepressureTool < ApplicationRecord
  belongs_to :patient
  has_many :assign_depressure_tools, dependent: :destroy
  has_many :depressure_tools, through: :assign_depressure_tools

  # 画像投稿用
  # carrierwaveのおまじない
  mount_uploader :image, ImageUploader

  def update(params)
    self.comment = params[:comment]
    # 画像が投稿された場合は書き換える
    self.image = params[:image] if params[:image]

    # has_manyフィールドの便利メソッド
    # フィールド名(単数形)_idsで差分を見て追加とか削除をおこなう
    self.depressure_tool_ids = params[:tool_ids]
  end
end

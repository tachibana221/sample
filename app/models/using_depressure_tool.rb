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

    # 一旦すでに登録されている使用物品を全部消してから新しく全部登録し直す
    # すでに登録されているものがもう一度登録されて重複したり、消したやつが消えなかったりするため
    # 多分一個一個登録されているレコードとparams[:tool_ids]のidを比較していって消すとか追加するとかするようにしたほうがいいと思う
    # 今のままだと保存されるたびに中間テーブルが作り直されていく
    depressure_tools.clear()
    depressure_tools << DepressureTool.find(params[:tool_ids])
  end
end

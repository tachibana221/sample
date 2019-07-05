# ケア物品モデル
class CareTool < ApplicationRecord
  # 名前は入力必須
  validates :name,  presence: true
  # ケア物品の種類のenum
  # めんどくさいから日本語だけど許しくれ
  enum genre: { "軟膏類": 1, "洗浄用品": 2, "被覆材・テープ類": 3, "衛生材料": 4 }

  # コントローラーから渡されたparamでカラムを更新する
  def update(params)
    self.name = params[:name]
    self.genre = params[:genre]
  end
end

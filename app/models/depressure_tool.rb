# 除圧用具モデル
class DepressureTool < ApplicationRecord
  # 名前は入力必須
  validates :name,  presence: true
  # 除圧用具の種類のenum
  # めんどくさいから日本語だけど許しくれ
  enum genre: { "その他": 0, "ベッド": 1, "車椅子": 2 }

  # コントローラーから渡されたparamでカラムを更新する
  def update(params)
    self.name = params[:name]
    self.genre = params[:genre]
  end
end

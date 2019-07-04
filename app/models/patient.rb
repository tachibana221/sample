class Patient < ApplicationRecord
  # 最終更新者用の看護師モデルへの参照
  belongs_to :topics_editor, class_name: "Nurse", foreign_key: 'topics_editor_id', optional: true
  belongs_to :image_editor, class_name: "Nurse", foreign_key: 'image_editor_id', optional: true

  # 画像投稿用
  mount_uploader :image, ImageUploader

  # 名前は入力必須項目
  validates :name, presence: true

  # 性別を表すenum
  # めんどくさいから日本語だけど許してくれ
  enum sex: { "未入力": 0, "男性": 1, "女性": 2, "その他":9 }

  def update(params, nurse)
    self.name = params[:name]
    self.name_kana = params[:name_kana]
    self.age = params[:age]
    self.sex = params[:sex]
    if self.topics != params[:topics]
      self.topics = params[:topics]
      self.topics_editor = nurse
      self.topics_updated_at = Date.today.to_time
    end

    if params[:image]
      self.image = params[:image]
      self.image_editor = nurse
      self.image_updated_at = Date.today.to_time
    end

  end
end

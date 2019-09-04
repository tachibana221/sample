class Patient < ApplicationRecord
  # 最終更新者用の看護師モデルへの参照
  belongs_to :topics_editor, class_name: 'Nurse', foreign_key: 'topics_editor_id', optional: true
  belongs_to :image_editor, class_name: 'Nurse', foreign_key: 'image_editor_id', optional: true

  has_many :bedsore_parts, dependent: :destroy
  has_one :using_care_tool, dependent: :destroy, class_name: 'UsingCareTool'
  has_one :using_depressure_tool, dependent: :destroy, class_name: 'UsingDepressureTool'

  # 画像投稿用
  # carrierwaveのおまじない
  mount_uploader :image, ImageUploader

  # 名前は入力必須項目
  validates :name, presence: true

  # 性別を表すenum
  enum sex: { "未入力": 0, "男性": 1, "女性": 2, "その他": 9 }

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    today = Time.now
    self.name = params[:name]
    self.name_kana = params[:name_kana]
    self.age = params[:age]
    self.sex = params[:sex]
    # トピックが入力されてかつ、値が変更されていた場合は書き換える
    if params[:topics] != '' && params[:topics] != topics
      self.topics = params[:topics]
      self.topics_editor = nurse
      self.topics_updated_at = today
    end

    # 画像が投稿された場合は書き換える
    if params[:image]
      self.image = params[:image]
      self.image_editor = nurse
    end

#     画像投稿日を書き換える
    self.image_updated_at = DateTime.new(
      params['image_updated_at(1i)'].to_i,
      params['image_updated_at(2i)'].to_i,
      params['image_updated_at(3i)'].to_i,
      params['image_updated_at(4i)'].to_i,
      params['image_updated_at(5i)'].to_i
    )
  end
end

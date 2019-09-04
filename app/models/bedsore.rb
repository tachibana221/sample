# 褥瘡

# 褥瘡に対する備考的な使いかたをするcommentカラムと
# 画像上に表示させるコメントを持つcommentsカラムがある
class Bedsore < ApplicationRecord
  belongs_to :bedsore_part
  belongs_to :image_editor, class_name: 'Nurse', foreign_key: 'image_editor_id', optional: true
  belongs_to :nurse, optional: true

  has_many :comments, dependent: :destroy

  has_one :design_r, dependent: :destroy, class_name: 'DesignR'
  
  # 画像投稿用
  # carrierwaveのおまじない
  mount_uploader :image, ImageUploader
  mount_uploader :handwrite_image, ImageUploader
  
  #画像登録の必須化
  validates_presence_of :image

  def comments_by_day
    comments.by_day_hash
  end

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    today = Time.now

    if params[:comment]
      self.comment = params[:comment]
      self.nurse = nurse
    end

    # 画像が投稿された場合は書き換える
    # base64を画像に変換
    if params[:image_base64] && params[:image_base64] != ''
      self.image = base64_conversion(params[:image_base64], 'image_' + today.strftime('%Y%m%d%H%M%S'))
      self.image_editor = nurse
      self.image_edited_at = today
    end

    # 手書き画像が投稿された場合は書き換える
    # deta urlで送られてきた場合は変換する
    if params[:handwrite_image_url]
      # base64で飛んでくるので変換する
      # 同じファイル名で上書きしていくとブラウザがキャッシュを使っちゃって古い画像が表示されることがあるので時刻をファイル名にする
      image_data = base64_conversion(params[:handwrite_image_url], 'handwrite_' + today.strftime('%Y%m%d%H%M%S'))
      self.handwrite_image = image_data
    end
  end

  # 画像上に表示する複数のコメントを更新する
  def updateComments(new_comments)
    new_comments.each_pair do |_, value|
      comment = comments.find(value[:id])
      comment.update(value)
      comment.save()
    end
  end

end

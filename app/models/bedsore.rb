# 褥瘡
class Bedsore < ApplicationRecord
  include CarrierwaveBase64Uploader
  belongs_to :bedsore_part
  belongs_to :image_editor, class_name: "Nurse", foreign_key: 'image_editor_id', optional: true
  belongs_to :nurse, optional: true

  has_many :comments, dependent: :destroy

  has_one :design_r, dependent: :destroy, class_name: "DesignR"

  # 画像投稿用
  # carrierwaveのおまじない
  mount_uploader :image, ImageUploader
  mount_uploader :handwrite_image, ImageUploader

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    today = Time.now

    if params[:comment]
      self.comment = params[:comment]
      self.nurse = nurse
    end
    
    # 画像が投稿された場合は書き換える
    if params[:image]
      self.image = params[:image]
      self.image_editor = nurse
      self.image_edited_at = today
    end

    # 手書き画像が投稿された場合は書き換える
    if params[:handwrite_image]
      self.handwrite_image = params[:handwrite_image]
    end

    # 手書き画像が投稿された場合は書き換える
    # deta urlで送られてきた場合は変換する
    if params[:handwrite_image_url]
      puts "hogeeeeeeeee"
      puts params
      # base64で飛んでくるので変換する
      # 同じファイル名で上書きしていくとブラウザがキャッシュを使っちゃって古い画像が表示されることがあるので時刻をファイル名にする
      image_data =  base64_conversion(params[:handwrite_image_url], "handwrite_" + today.strftime('%Y%m%d%H%M%S'))
      self.handwrite_image = image_data
    end
  end
end

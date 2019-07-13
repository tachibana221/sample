# 褥瘡
class Bedsore < ApplicationRecord
  include CarrierwaveBase64Uploader
  belongs_to :bedsore_part
  belongs_to :image_editor, class_name: "Nurse", foreign_key: 'image_editor_id', optional: true
  belongs_to :nurse, optional: true

  has_one :design_r, dependent: :destroy, class_name: "DesignR"

  # 画像投稿用
  # carrierwaveのおまじない
  mount_uploader :image, ImageUploader
  mount_uploader :handwrite_image, ImageUploader

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    today = Date.today.to_time
    self.comment = params[:comment]
    self.nurse = nurse
    
    # 画像が投稿された場合は書き換える
    if params[:image]
      self.image = params[:image]
      self.image_editor = nurse
      self.image_edited_at = today
    end

    # 画像が投稿された場合は書き換える
    if params[:handwrite_image]
      self.handwrite_image = params[:handwrite_image]
    end

    # 手書き画像が投稿された場合は書き換える
    if params[:remote_handwrite_image_url]
      # base64で飛んでくるので変換する
      puts today.to_time.to_i.to_s
      image_data =  base64_conversion(params[:remote_handwrite_image_url], "handwrite" + today.to_time.to_i.to_s)
      self.handwrite_image = image_data
      self.remote_handwrite_image_url = nil
    end
  end
end

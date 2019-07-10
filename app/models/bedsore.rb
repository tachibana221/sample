class Bedsore < ApplicationRecord
  belongs_to :bedsore_part
  belongs_to :image_editor, class_name: "Nurse", foreign_key: 'image_editor_id', optional: true
  belongs_to :nurse, optional: true

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
      self.image = params[:handwrite_image]
    end
  end
end

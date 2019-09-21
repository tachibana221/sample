class CareInfo < ApplicationRecord
  belongs_to :bedsore_part
  belongs_to :image_editor, class_name: 'Nurse', foreign_key: 'image_editor_id', optional: true
  belongs_to :comment_editor, class_name: 'Nurse', foreign_key: 'comment_editor_id', optional: true
  belongs_to :nurse, optional: true
  acts_as_list :scope => :bedsore_part

  # 画像投稿用
  # carrierwaveのおまじない
  mount_uploader :image, ImageUploader

  # コントローラーから渡されたparamでカラムを更新する
  def update(params, nurse)
    today = Time.now
    # コメントが入力されてかつ、値が変更されていた場合は書き換える
    if params[:comment] != '' && params[:comment] != comment
      self.comment = params[:comment]
      self.comment_editor = nurse
      self.comment_edited_at = today
    end

    # 画像が投稿された場合は書き換える
    if params[:image]
      self.image = params[:image]
      self.image_editor = nurse
      self.image_edited_at = today
    end
  end
end

class CareInfo < ApplicationRecord
  belongs_to :image_editor, class_name: "Nurse", foreign_key: 'image_editor_id', optional: true
  belongs_to :comment_editor, class_name: "Nurse", foreign_key: 'comment_editor_id', optional: true
  belongs_to :nurse, optional: true
end

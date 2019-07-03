class Patient < ApplicationRecord
  belongs_to :topics_editor, class_name: "Nurse"
  validates :name, presence: true
end

class Patient < ApplicationRecord
  belongs_to :topics_editor, class_name: "Nurse"
  validates :name, presence: true

  def update(params, nurse)
    self.name = params[:name]
    self.name_kana = params[:name_kana]
    self.age = params[:age]
    self.sex = params[:sex]
    puts self.topics
    puts params[:topics]
    if self.topics != params[:topics]
      puts "eeeeeeeeeeeeee"
      self.topics = params[:topics]
      self.topics_editor = nurse
      self.topics_updated_at = Date.today.to_time
    end
  end
end

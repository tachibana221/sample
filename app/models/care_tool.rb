class CareTool < ApplicationRecord
  validates :name,  presence: true
  enum genre: { "軟膏類": 1, "洗浄用品": 2, "被覆材・テープ類": 3, "衛生材料": 4 }

  def update(params)
    self.name = params[:name]
    self.genre = params[:genre]
  end
end

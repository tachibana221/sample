class DepressureTool < ApplicationRecord
  validates :name,  presence: true
  enum genre: { "その他": 0, "ベッド": 1, "車椅子": 2 }

  def update(params)
    self.name = params[:name]
    self.genre = params[:genre]
  end
end

class Comment < ApplicationRecord
  belongs_to :bedsore

  def update(params)
    self.text = params[:text]
    self.position_x = params[:position_x]
    self.position_y = params[:position_y]
  end
end

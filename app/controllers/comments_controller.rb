class CommentsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    bedsore_id = params[:bedsore_id]
    @bedsore = Bedsore.find(bedsore_id)
    comment = @bedsore.comments.build()
    comment.update(params)
    if comment.save()
      flash[:notice] = '新しくコメントを登録しました'
      redirect_back(fallback_location: root_path)
    end
  end
end

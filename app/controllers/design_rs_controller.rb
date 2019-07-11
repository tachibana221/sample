class DesignRsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
    @designR = DesignR.find(params[:id])
    @designR.update(params[:design_r])
    if @designR.save()
      flash[:notice] = 'DesignR情報を更新しました'
      redirect_back(fallback_location: root_path)
    end
  end
end

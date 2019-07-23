class DesignRsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check
  
  def index
    @designRs = DesignR.all()
  end

  def show
    @designR = DesignR.find(params[:id])
  end

  def new
    @designR = DesignR.new()
  end

  def edit
    @designR = DesignR.find(params[:id])
  end

  def update
    @designR = DesignR.find(params[:id])
    @designR.update(params[:design_r])
    if @designR.save()
      flash[:primary] = 'DesignR情報を更新しました'
      redirect_to("/bedsores/#{@designR.bedsore.id}")
    end
  end
end

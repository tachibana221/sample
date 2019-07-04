class DepressureToolsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check, only: [:new, :edit, :update, :destroy]

  def index
    @tools = DepressureTool.all()
  end

  def new
    @tool = DepressureTool.new()
  end

  def show
    @tool = DepressureTool.find_by(id: params[:id])
  end

  def edit
    @tool = DepressureTool.find_by(id: params[:id])
  end

  def create
    @tool = DepressureTool.new()
    @tool.update(params[:depressure_tool])
    if @tool.save()
      flash[:notice] = '新しく除圧用具を登録しました'
      redirect_to('/depressure_tools')
    else
      render('depressure_tools/new')
    end
  end

  def update
    @tool = DepressureTool.find_by(id: params[:id])
    @tool.update(params[:depressure_tool])
    if @tool.save()
      flash[:notice] = '新しく除圧用具を登録しました'
      redirect_to('/depressure_tools')
    else
      render('depressure_tools/new')
    end
  end

  def destroy
    @tool = DepressureTool.find_by(id: params[:id])
    @tool.destroy()
    redirect_to('/depressure_tools')
  end
end

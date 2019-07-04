class CareToolsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check, only: [:new, :edit, :update, :destroy]

  def index
    @tools = CareTool.all()
  end

  def new
    @tool = CareTool.new()
  end

  def show
    @tool = CareTool.find_by(id: params[:id])
  end

  def edit
    @tool = CareTool.find_by(id: params[:id])
  end

  def create
    @tool = CareTool.new()
    @tool.update(params[:care_tool])
    if @tool.save()
      flash[:notice] = '新しくケア物品を登録しました'
      redirect_to('/care_tools')
    else
      render('care_tools/new')
    end
  end

  def update
    @tool = CareTool.find_by(id: params[:id])
    @tool.update(params[:care_tool])
    if @tool.save()
      flash[:notice] = '新しくケア物品を登録しました'
      redirect_to('/care_tools')
    else
      render('care_tools/new')
    end
  end

  def destroy
    @tool = CareTool.find_by(id: params[:id])
    @tool.destroy()
    redirect_to('/care_tools')
  end
end

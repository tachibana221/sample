# ケア物品コントローラー
class CareToolsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check, only: [:new, :edit, :update, :destroy]

  # 一覧ページ
  def index
    @tools = CareTool.all()
  end

  # 新規作成ページ
  def new
    @tool = CareTool.new()
  end

  # 詳細ページ
  def show
    @tool = CareTool.find_by(id: params[:id])
  end

  # 編集ページ
  def edit
    @tool = CareTool.find_by(id: params[:id])
  end

  # 新規作成
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

  # 登録情報更新
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

  # 削除
  def destroy
    @tool = CareTool.find_by(id: params[:id])
    @tool.destroy()
    redirect_to('/care_tools')
  end
end

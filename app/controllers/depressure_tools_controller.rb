# 除圧用具コントローラー
class DepressureToolsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index
    @tools = DepressureTool.all()
  end

  # 新規作成ページ
  def new
    @tool = DepressureTool.new()
  end

  # 詳細ページ
  def show
    @tool = DepressureTool.find_by(id: params[:id])
  end

  # 編集ページ
  def edit
    @tool = DepressureTool.find_by(id: params[:id])
  end

  # 新規作成
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

  # 登録情報更新
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

  # 削除
  def destroy
    @tool = DepressureTool.find_by(id: params[:id])
    @tool.destroy()
    redirect_to('/depressure_tools')
  end
end

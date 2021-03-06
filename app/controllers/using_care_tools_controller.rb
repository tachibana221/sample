class UsingCareToolsController < ApplicationController

  # 一覧ページ
  def index; end

  # 詳細ページ
  def show
    @using_care_tool = UsingCareTool.find(params[:id])
    @care_tools = CareTool.all()
  end

  # 編集ページ
  def edit
    @using_care_tool = UsingCareTool.find(params[:id])
    @care_tools = CareTool.all()
  end

  # 登録情報更新
  def update
    @using_care_tool = UsingCareTool.find(params[:id])
    @using_care_tool.update(params[:using_care_tool])
    if @using_care_tool.save()
      flash[:primary] = '登録情報を更新しました'
      redirect_to("/using_care_tools/#{params[:id]}")
    else
      @care_tools = CareTool.all()
      render('using_care_tools/edit')
    end
  end
end

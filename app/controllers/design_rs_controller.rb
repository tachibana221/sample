class DesignRsController < ApplicationController
  # ログイン済みのユーザーかどうかのチェック
  before_action :login_check

  # 一覧ページ
  def index
    @designRs = DesignR.all()
  end

  # 詳細ページ
  def show
    @designR = DesignR.find(params[:id])
  end

  # 新規作成ページ
  def new
    @designR = DesignR.new()
  end

  # 編集ページ
  def edit
    @designR = DesignR.find(params[:id])
  end

  # 登録情報更新
  def update
    @designR = DesignR.find(params[:id])
    @designR.update(params[:design_r])
    if @designR.save()
      flash[:primary] = 'DesignR情報を更新しました'
      redirect_to("/bedsores/#{@designR.bedsore.id}")
    end
  end
end

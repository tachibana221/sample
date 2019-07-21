# 看護師コントローラー
class NursesController < ApplicationController
  before_action :login_check, only: [:destroy]

  # 一覧ページ
  def index
    @nurses = Nurse.all()
  end

  # 詳細ページ
  def show
    @nurse = Nurse.find_by(id: params[:id])
  end

  # 新規作成ページ
  def new
    @nurse = Nurse.new()
  end

  # 編集ページ
  def edit
    @nurse = Nurse.find_by(id: params[:id])
  end

  # 新規作成メソッド
  def create
    @nurse = Nurse.new()
    # フォームの値取り出し
    @nurse.update(params[:nurse])
    if @nurse.save()
      flash[:primary] = '新しく看護師を登録しました'
      redirect_to('/nurses')
    else
      render('nurses/new')
    end
  end

  # 更新メソッド
  def update
    @nurse = Nurse.find_by(id: params[:id])
    # フォームの値取り出し
    @nurse.update(params[:nurse])
    if @nurse.save()
      flash.now[:primary] = '登録情報を更新しました'
      redirect_to("/nurses/#{params[:id]}")
    else
      render("nurses/edit")
    end
  end

  # 削除メソッド
  def destroy
    @nurse = Nurse.find_by(id: params[:id])
    @nurse.destroy()
    redirect_to('/nurses')
  end
end

# 看護師コントローラー
class NursesController < ApplicationController
  before_action :login_check, only: [:destroy]

  # 一覧ページ
  def index
    @nurses = Nurse.all()
  end

  # 詳細ページ
  def show
    @nurse = Nurse.find(params[:id])
  end

  # 新規作成ページ
  def new
    @nurse = Nurse.new()
  end

  # 編集ページ
  def edit
    @nurse = Nurse.find(params[:id])
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
    @nurse = Nurse.find(params[:id])
    # フォームの値取り出し
    @nurse.update(params[:nurse])
    if @nurse.save()
      flash[:primary] = '登録情報を更新しました'
      redirect_to("/nurses/#{params[:id]}")
    else
      render('nurses/edit')
    end
  end

  # 削除メソッド
  def destroy
    @nurse = Nurse.find(params[:id])
    # 現在ログインしているアカウントは削除できないように
    if @nurse.id == current_nurse.id
      flash[:danger] = 'ログイン中のアカウントは削除できません'
    else
      @nurse.destroy()
    end

    redirect_to('/nurses')
  end
end

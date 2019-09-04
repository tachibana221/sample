# ログイン情報コントローラー
class SessionsController < ApplicationController

  # 一覧ページ
  def index
    @nurses = Nurse.all()
  end

  # 新規作成ページ
  def new
    @nurse = Nurse.find(params[:id])
  end

  # 新規作成
  def create
    @nurse = Nurse.find(params[:id])
    # レコードが存在して、入力されたパスワードが正しいならログインさせる
    if @nurse&.authenticate(params[:password])
      log_in(@nurse)
      # ブラウザを閉じてもログイン情報が保持されるようにする
      remember(@nurse)
      flash[:primary] = 'ログインしました'
      redirect_to('/')
    else
      # エラー文を表示させる
      flash.now[:danger] = 'パスワードが正しくありません'
      render 'new'
    end
  end

  # 削除
  def destroy
    log_out if logged_in?
    flash[:danger] = 'ログアウトしました'
    redirect_to('/')
  end
end

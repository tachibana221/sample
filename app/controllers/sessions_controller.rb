# ログイン情報コントローラー
class SessionsController < ApplicationController
  def index
    @nurses = Nurse.all()
  end

  def new
    @nurse = Nurse.find_by(id: params[:id])
  end

  def create
    @nurse = Nurse.find_by(id: params[:id])
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

  def destroy
    log_out if logged_in?
    flash[:danger] = 'ログアウトしました'
    redirect_to('/')
  end
end

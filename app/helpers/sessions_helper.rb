module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(nurse)
    session[:nurse_id] = nurse.id
  end

  # 現在ログイン中の看護師を返す
  def current_nurse
    @current_nurse ||= Nurse.find_by(id: session[:nurse_id])
  end

  # ログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_nurse.nil?
  end
end

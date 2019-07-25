module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(nurse)
    session[:nurse_id] = nurse.id
  end

  # 現在ログイン中の看護師を返す
  def current_nurse
    if (nurse_id = session[:nurse_id])
      @current_nurse ||= Nurse.find_by(id: nurse_id)
    elsif (nurse_id = cookies.signed[:nurse_id])
      nurse = Nurse.find_by(id: nurse_id)
      if nurse&.authenticated?(cookies[:remember_token])
        log_in(nurse)
        @current_nurse = nurse
      end
    end
  end

  # ログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_nurse.nil?
  end

  # ログアウトする
  def log_out
    forget(current_nurse)
    session.delete(:nurse_id)
    @current_nurse = nil
  end

  # ログイン情報を永続的にする
  def remember(nurse)
    nurse.remember
    cookies.permanent.signed[:nurse_id] = nurse.id
    cookies.permanent[:remember_token] = nurse.remember_token
  end

  # ログイン情報を破棄する
  def forget(nurse)
    nurse.forget
    cookies.delete(:nurse_id)
    cookies.delete(:remember_token)
  end

  # ログインしているかチェック
  def login_check
    unless logged_in?
      flash[:danger] = 'この操作を行うにはログインする必要があります'
      redirect_to('/login')
    end
  end
end

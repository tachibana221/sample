class Nurse < ApplicationRecord
  # ログイン状態を保持するためのトークン保存用
  attr_accessor :remember_token

  # カラムのバリデート
  validates :name,  presence: true
  validates :name_kana,  presence: true  
  validates :password, presence: true  
  has_secure_password

  # 渡された文字列のハッシュ値を返す
  def Nurse.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def Nurse.new_token
    SecureRandom.urlsafe_base64
  end

  # ログイン状態を保持する
  def remember
    self.remember_token = Nurse.new_token
    update_attribute(:remember_digest, Nurse.digest(remember_token))
  end

  # トークンが有効か（ログイン済みかどうか）
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

end

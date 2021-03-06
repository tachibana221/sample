class Nurse < ApplicationRecord
  # ログイン状態を保持するためのトークン保存用
  attr_accessor :remember_token

  # ほかモデルへの関連付け
  has_many :edited_topics_patients, class_name: 'Patient', foreign_key: 'topics_editor_id', dependent: :nullify
  has_many :edited_image_patients, class_name: 'Patient', foreign_key: 'image_editor_id', dependent: :nullify
  has_many :edited_image_care_info, class_name: 'CareInfo', foreign_key: 'comment_editor_id', dependent: :nullify
  has_many :edited_image_care_info, class_name: 'CareInfo', foreign_key: 'image_editor_id', dependent: :nullify
  has_many :edited_image_bedsore, class_name: 'Bedsore', foreign_key: 'image_editor_id', dependent: :nullify
  has_many :care_infos, dependent: :nullify
  has_many :bedsore_parts, dependent: :nullify
  has_many :bedsores, dependent: :nullify

  # カラムのバリデート
  # 名前とパスワードは入力必須
  validates :name, presence: true
  validates :password, presence: true, allow_nil: true
  # bcryptを使うためのおまじない
  has_secure_password

  # コントローラーから渡されたparamでカラムを更新する
  def update(params)
    self.name = params[:name]
    self.name_kana = params[:name_kana]
    # パスワードが入力されていたら更新する
    if params[:password] && params[:password_confirmation]
      self.password = params[:password]
      self.password_confirmation = params[:password_confirmation]
    end
  end

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
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

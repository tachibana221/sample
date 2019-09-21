class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # base64から画像に変換するためのモジュール
  include CarrierwaveBase64Uploader

  # 文字列カラムに絵文字が含まれていないかをチェック
  validates_with EmojiValidator

end

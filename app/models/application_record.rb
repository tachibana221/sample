class ApplicationRecord < ActiveRecord::Base
  include CarrierwaveBase64Uploader
  self.abstract_class = true
end

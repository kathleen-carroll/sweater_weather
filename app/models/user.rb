require 'securerandom'

class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password

  def get_api_key
    self.api_key = SecureRandom.hex
  end
end

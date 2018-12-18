class Account < ApplicationRecord
  validates :email, presence: true
  validates :password, presence: true, on: :create

  has_secure_password
end

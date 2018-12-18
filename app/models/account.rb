class Account < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :password, presence: true, on: :create

  before_create { generate_token(:auth_token) }

  def remember
    generate_token(:auth_token)
    save
  end

  def forget
    update_attribute(:auth_token, nil)
  end
end

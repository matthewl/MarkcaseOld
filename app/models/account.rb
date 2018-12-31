class Account < ApplicationRecord
  has_secure_password
  has_many :bundles
  accepts_nested_attributes_for :bundles, allow_destroy: true, reject_if: :all_blank

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

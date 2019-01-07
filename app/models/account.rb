class Account < ApplicationRecord
  has_secure_password
  has_many :bundles
  accepts_nested_attributes_for :bundles, allow_destroy: true, reject_if: :all_blank

  validates :email, presence: true
  validates :password, presence: true, on: :create

  after_find { ensure_rss_auth_token_present }
  before_create { generate_token(:auth_token) }
  before_create { generate_token(:rss_auth_token) }

  def remember
    generate_token(:auth_token)
    save
  end

  def forget
    update_attribute(:auth_token, nil)
  end

  private

  def generate_token(column)
    self[column] = SecureRandom.urlsafe_base64
  end

  def ensure_rss_auth_token_present
    return if rss_auth_token.present?
    generate_token(:rss_auth_token)
    save
  end
end

class Bundle < ApplicationRecord
  scope :shared, -> { where(shared: true) }

  belongs_to :account
  validates :name, presence: true
end

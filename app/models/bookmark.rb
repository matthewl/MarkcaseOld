class Bookmark < ApplicationRecord
  scope :shared, -> { where(shared: true) }

  belongs_to :account

  validates :url, uniqueness: { case_sensitive: false }, presence: true
  validates :title, presence: true

  def tags=(values)
    super(values.split(' '))
  end
end

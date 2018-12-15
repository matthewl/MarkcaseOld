class Bookmark < ApplicationRecord
  validates :url, uniqueness: { case_sensitive: false }, presence: true
  validates :title, presence: true
end

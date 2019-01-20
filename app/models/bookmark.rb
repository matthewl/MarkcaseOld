class Bookmark < ApplicationRecord
  acts_as_taggable

  scope :shared, -> { where(shared: true) }
  scope :counted_tags, -> { tag_counts_on(:tags).sort_by { |tag| tag.taggings_count }.reverse }

  belongs_to :account

  validates :url, uniqueness: { case_sensitive: false }, presence: true
  validates :title, presence: true

  def tags=(values)
    super(values.split(' '))
  end
end

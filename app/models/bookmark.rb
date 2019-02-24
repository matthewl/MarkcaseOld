# frozen_string_literal: true

class Bookmark < ApplicationRecord
  acts_as_taggable

  scope :shared, -> { where(shared: true) }
  scope :counted_tags, -> { tag_counts_on(:tags).sort_by(&:taggings_count).reverse }

  belongs_to :account

  validates :url, uniqueness: { case_sensitive: false }, presence: true
  validates :title, presence: true

  def tags=(values)
    super(values.split(' '))
  end

  def tags_as_input
    tags.sort.join(', ')
  end
end

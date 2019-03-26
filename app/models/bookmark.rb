# frozen_string_literal: true

class Bookmark < ApplicationRecord
  acts_as_taggable

  scope :shared, -> { where(shared: true) }
  scope :counted_tags, -> { tag_counts_on(:tags).sort_by(&:taggings_count).reverse }
  scope :for_feeds, -> { where(shared: true).order('created_at DESC').limit(25) }
  scope :by_host, ->(host, id) { where('url LIKE ?', "%#{host}%").order('created_at DESC').limit(5).where.not(id: id) }

  belongs_to :account

  validates :url, uniqueness: { case_sensitive: false }, presence: true
  validates :title, presence: true

  def find_by_host
    account.bookmarks.by_host(host, id)
  end

  def tags_as_input
    tags.sort.join(', ')
  end

  def host
    URI.parse(url).host
  end
end

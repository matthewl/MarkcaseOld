class HomeController < ApplicationController
  def index
    @bookmarks = Bookmark.all.order('created_at DESC')
  end
end

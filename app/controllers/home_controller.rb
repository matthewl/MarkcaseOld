class HomeController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @bookmarks = pagy(Bookmark.all.order('created_at DESC'))
    @tags = TagCloud.all
  end
end

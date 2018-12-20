class HomeController < ApplicationController
  include Pagy::Backend
  skip_before_action :verify_account

  def index
    @pagy, @bookmarks = pagy(Bookmark.all.order('created_at DESC'))
    @tags = TagCloud.all
  end
end

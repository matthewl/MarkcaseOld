class FeedsController < ApplicationController
  skip_before_action :verify_account
  skip_before_action :verify_public_site

  def index
    if owner.public_site?
      @bookmarks = Bookmark.shared.order('created_at DESC').limit(25)

      respond_to do |format|
        format.rss { render layout: false }
      end
    else
      render json: { message: 'The RSS feed for this site is private.' }, status: :unauthorized
    end
  end
end
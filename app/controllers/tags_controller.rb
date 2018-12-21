class TagsController < ApplicationController
  include Pagy::Backend
  skip_before_action :verify_account

  def show
    @pagy, @bookmarks =
      if current_account
        pagy(Bookmark.where("'#{params[:name]}' = ANY (tags)").order('created_at DESC'))
      else
        pagy(Bookmark.visible.where("'#{params[:name]}' = ANY (tags)").order('created_at DESC'))
      end
    @tags = TagCloud.all
    render :show
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tags)
  end
end

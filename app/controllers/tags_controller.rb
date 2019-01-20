class TagsController < ApplicationController
  include Pagy::Backend
  skip_before_action :verify_account

  def show
    @tags = find_tags_for_cloud
    @pagy, @bookmarks =
      if current_account
        pagy(Bookmark.where("'#{params[:name]}' = ANY (tags)").order('created_at DESC'))
      else
        pagy(Bookmark.shared.where("'#{params[:name]}' = ANY (tags)").order('created_at DESC'))
      end
    render :show
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tags)
  end
end

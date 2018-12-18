class TagsController < ApplicationController
  def show
    @bookmarks = Bookmark.where("'#{params[:name]}' = ANY (tags)").order('created_at DESC')
    render :show
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tags)
  end
end

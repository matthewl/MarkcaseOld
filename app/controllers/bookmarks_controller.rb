class BookmarksController < ApplicationController
  skip_before_action :verify_public_site
  def new
    @bookmark = Bookmark.new
    @tags = TagCloud.all
    render :new
  end

  def create
    @bookmark = Bookmark.new
    @tags = TagCloud.all
    if @bookmark.update_attributes(bookmark_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    @tags = TagCloud.all
    render :edit
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @tags = TagCloud.all
    if @bookmark.update_attributes(bookmark_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.delete
    redirect_to root_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tags, :shared)
  end
end

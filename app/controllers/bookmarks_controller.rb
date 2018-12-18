class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    render :new
  end

  def create
    @bookmark = Bookmark.new
    if @bookmark.update_attributes(bookmark_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    render :edit
  end

  def update
    @bookmark = Bookmark.find(params[:id])
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
    params.require(:bookmark).permit(:title, :description, :url, :tags)
  end
end

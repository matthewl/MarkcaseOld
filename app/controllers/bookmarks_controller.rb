class BookmarksController < ApplicationController
  before_action :find_tags, except: :destroy
  skip_before_action :verify_public_site
  def new
    @bookmark = Bookmark.new
    render :new
  end

  def create
    @bookmark = Bookmark.new(account_id: current_account.id)
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

  def find_tags
    @tags = find_tags_for_cloud
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tag_list, :shared)
  end
end

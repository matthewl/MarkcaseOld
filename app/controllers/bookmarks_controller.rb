# frozen_string_literal: true

class BookmarksController < AuthenticatedController
  before_action :find_tags, except: :destroy

  def new
    @account = current_account
    @bookmark = Bookmark.new
    render :new
  end

  def create
    @account = current_account
    @bookmark = Bookmark.new(account_id: current_account.id)
    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmarks
    else
      render :new
    end
  end

  def edit
    @account = current_account
    @bookmark = current_account.bookmarks.find(params[:id])
    render :edit
  end

  def update
    @account = current_account
    @bookmark = current_account.bookmarks.find(params[:id])
    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmarks
    else
      render :edit
    end
  end

  def destroy
    bookmark = current_account.bookmarks.find(params[:id])
    bookmark.delete
    redirect_to bookmarks
  end

  private

  def find_tags
    @tags = find_tags_for_cloud(current_account)
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tag_list, :shared)
  end

  def bookmarks
    return user_path(username: current_account.login)
  end
end

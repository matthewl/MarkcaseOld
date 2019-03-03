class TagsController < ApplicationController
  include Pagy::Backend
  before_action :verify_account_exists
  before_action :verify_public_account

  def show
    @account = account
    @tags = account.bookmarks.counted_tags
    @pagy, @bookmarks = pagy(account.bookmarks.tagged_with(params[:name]).order('created_at DESC'))
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :description, :url, :tags)
  end

  def verify_account_exists
    if current_account
      redirect_to user_path(username: current_account.login) unless account.present?
    else
      redirect_to root_path unless account.present?
    end
  end

  def verify_public_account
    if current_account
      redirect_to user_path(username: current_account.login) unless public_account? || account == current_account
    else
      redirect_to root_path unless public_account?
    end
  end

  def account
    @account ||= Account.find_by(login: params[:username])
  end

  def public_account?
    account.public_site?
  end
end

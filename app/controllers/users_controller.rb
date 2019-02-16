# frozen_string_literal :true
class UsersController < ApplicationController
  include Pagy::Backend

  skip_before_action :verify_account
  skip_before_action :verify_public_site
  before_action :verify_user_public_site

  def show
    @tags = account.bookmarks.counted_tags
    @pagy, @bookmarks = pagy(account.bookmarks.all.order('created_at DESC'))
  end

  private

  def verify_user_public_site
    redirect_to login_path unless account.public_site?
  end

  def account
    @account ||= Account.find_by(login: params[:username])
  end
end
# frozen_string_literal: true

class HomeController < ApplicationController
  include Pagy::Backend
  include SessionsHelper
  skip_before_action :verify_account

  def index
    if Settings.first.single_account?
      @tags = find_tags_for_cloud
      @pagy, @bookmarks = current_account_bookmarks
      render :single
    else
      render :landing, layout: 'landing'
    end
  end

  def create
    account = Account.find_by(login: params[:login])

    if valid_account!(account)
      log_in account
      params[:remember_me] == 'on' ? remember(account) : forget(account)
      redirect_to user_path(username: account.login)
    else
      flash.now[:error] = t('authentication.error')
      render :new, layout: 'blank'
    end
  end

  private

  def current_account_bookmarks
    if current_account
      pagy(Bookmark.all.order('created_at DESC'))
    else
      pagy(Bookmark.shared.order('created_at DESC'))
    end
  end

  def valid_account!(account)
    account&.authenticate(params[:password])
  end
end

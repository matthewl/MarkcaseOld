# frozen_string_literal: true

class HomeController < ApplicationController
  include SessionsHelper

  def index
    render :index, layout: 'landing'
  end

  def create
    account = Account.find_by(login: params[:login])

    if valid_account!(account)
      log_in account
      params[:remember_me] == 'on' ? remember(account) : forget(account)
      redirect_to user_path(username: account.login)
    else
      flash.now[:error] = t('authentication.error')
      render :index, layout: 'landing'
    end
  end

  private

  def valid_account!(account)
    account&.authenticate(params[:password])
  end
end

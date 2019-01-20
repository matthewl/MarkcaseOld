class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_account, only: %i[new create]
  skip_before_action :verify_public_site

  def new
    return redirect_to bookmarks_path if current_account
    render layout: 'blank'
  end

  def create
    account = Account.find_by(login: params[:login])

    if valid_account!(account)
      log_in account
      params[:remember_me] == 'on' ? remember(account) : forget(account)
      redirect_to root_path
    else
      flash.now[:error] = t('authentication.error')
      render :new, layout: 'blank'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def valid_account!(account)
    account&.authenticate(params[:password])
  end
end

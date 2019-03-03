class SetupController < ApplicationController
  include SessionsHelper

  def new
    verify_setup_complete; return if performed?
    @account = Account.new(single_account: true)
    render :new, layout: 'blank'
  end

  def create
    verify_setup_complete; return if performed?
    @account = Account.new
    if @account.update_attributes(account_params)
      Setting.create(single_account: true)
      log_in @account
      remember(@account)
      redirect_to user_path(username: current_account.login)
    else
      render :new, layout: 'blank'
    end
  end

  private

  def verify_setup_complete
    unless Account.count.zero?
      if Setting.first.single_account?
        redirect_to user_path(username: Account.first.login) and return
      else
        redirect_to root_path and return
      end
    end
  end

  def account_params
    params
      .require(:account)
      .permit(
        :login, :email, :password, :password_confirmation
      )
  end
end

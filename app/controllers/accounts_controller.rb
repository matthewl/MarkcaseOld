# frozen_string_literal: true

class AccountsController < ApplicationController
	include SessionsHelper

  def new
    if Setting.first.single_account?
      redirect_to root_path
    else
      render :new
    end
  end

  def create
  	@account = Account.new()
  	if @account.update_attributes(account_params)
  		log_in @account
  		redirect_to user_path(username: @account.login)
  	else
  		render :new
  	end

  end

  def destroy
    account = current_account
    account.destroy
    redirect_to root_url, notice: t('account.destroyed')
  end

  private

  def account_params
		 params.require(:account).permit(:login, :email, :password)	
  end
end

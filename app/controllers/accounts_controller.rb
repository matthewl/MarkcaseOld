# frozen_string_literal: true

class AccountsController < ApplicationController
	include SessionsHelper

  def new
    if Setting.first.single_account? || !FT.on?(:accepting_registrations)
      redirect_to root_path
    else
      @account = Account.new
      render :new, layout: 'blank'
    end
  end

  def create
  	@account = Account.new()
  	if @account.update_attributes(account_params)
  		log_in @account
  		redirect_to user_path(username: @account.login)
  	else
      puts @account.errors.inspect
  		render :new, layout: 'blank'
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

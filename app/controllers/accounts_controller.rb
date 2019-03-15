# frozen_string_literal: true

class AccountsController < ApplicationController
  def new
    if Setting.first.single_account?
      redirect_to root_path
    else
      render :new
    end
  end

  def create

  end

  def destroy
    account = current_account
    account.destroy
    redirect_to root_url, notice: t('account.destroyed')
  end
end

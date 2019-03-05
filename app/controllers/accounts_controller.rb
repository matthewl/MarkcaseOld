# frozen_string_literal: true

class AccountsController < ApplicationController
  def destroy
    account = current_account
    account.destroy
    redirect_to root_url, notice: t('account.destroyed')
  end
end

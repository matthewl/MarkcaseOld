# frozen_string_literal: true

class PreferencesController < ApplicationController
  include SessionsHelper

  before_action :find_account, :find_tags
  skip_before_action :verify_public_site

  def edit
    render :edit
  end

  def update
    if @account.update_attributes(account_params)
      redirect_to bookmarks
    else
      render :edit
    end
  end

  private

  def find_account
    @account = current_account
  end

  def find_tags
    @tags = find_tags_for_cloud
  end

  def account_params
    params
      .require(:account)
      .permit(
        :login, :email, :public_site,
        bundles_attributes: %i[id name tags shared _destroy]
      )
  end

  def bookmarks
    return root_path if Setting.first.single_account?
    user_path(username: current_account.login)
  end
end

class PreferencesController < ApplicationController
  include SessionsHelper

  before_action :find_account, :find_tags
  skip_before_action :verify_public_site

  def edit
    render :edit
  end

  def update
    if @account.update_attributes(account_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def find_account
    @account = current_account
  end

  def find_tags
    @tags = TagCloud.all
  end

  def account_params
    params.require(:account).permit(:public_site, bundles_attributes: %i[id name tags shared _destroy])
  end
end

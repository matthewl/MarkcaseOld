class PreferencesController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_public_site

  def edit
    @account = current_account
    @tags = TagCloud.all
    render :edit
  end

  def update
    @account = current_account
    @tags = TagCloud.all
    if @account.update_attributes(account_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:public_site, bundles_attributes: [ :id, :name, :tags, :_destroy])
  end
end

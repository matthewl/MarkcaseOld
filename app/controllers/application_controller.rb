class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :verify_account
  before_action :verify_public_site

  private

  def verify_account
    redirect_to login_path unless current_account
  end

  def verify_public_site
    redirect_to login_path unless current_account || owner.public_site?
  end

  def owner
    Account.first
  end
end

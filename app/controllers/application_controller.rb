class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :verify_account
  before_action :verify_public_site

  def find_tags_for_cloud
    current_account.bookmarks.counted_tags
  end

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

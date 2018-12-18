class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :verify_account

  private

  def verify_account
    redirect_to login_path unless current_account
  end
end

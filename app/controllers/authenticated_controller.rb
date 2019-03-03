# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :verify_account

  private

  def verify_account
    redirect_to root_path unless current_account
  end
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'support/test_password_helper'

ActiveRecord::FixtureSet.context_class.send :include, TestPasswordHelper

class ActiveSupport::TestCase
  fixtures :all

  def log_in_as(account)
    session[:account_id] = account.id
  end

  def signin_as_private_user
    log_in_as(accounts(:drew))
  end

  def switch_to_single_tennant
    accounts(:drew).destroy
    settings(:global).update_attribute(:single_account, true)
  end
end

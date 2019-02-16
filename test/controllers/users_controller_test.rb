# frozen_string_literal :true
require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'show action responds with success' do
    get :show, params: { username: accounts(:jennifer).login }
    assert_response :success
  end

  test 'redirects to login page when account is private' do
    get :show, params: { username: accounts(:drew).login }
    assert_redirected_to login_path
  end
end

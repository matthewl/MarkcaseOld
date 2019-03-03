# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'show action responds with success' do
    get :show, params: { username: accounts(:jennifer).login }
    assert_response :success
  end

  test 'redirects to login page when account is private' do
    get :show, params: { username: accounts(:drew).login }
    assert_redirected_to root_path
  end

  test 'redirects to login page when account is not found' do
    get :show, params: { username: 'bob' }
    assert_redirected_to root_path
  end

  test 'does not redirect when it is our own user page' do
    signin_as_private_user
    get :show, params: { username: accounts(:drew).login }
    assert_response :success
  end
end

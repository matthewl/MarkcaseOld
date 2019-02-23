# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'renders the first account for single account installations' do
    accounts(:drew).destroy
    get :index
    assert_match 'ACME Literature', @response.body
    assert_match 'Just another literature website', @response.body
  end

  test 'renders the landing page for multi-account installations' do
    Settings.first.update_attribute(:single_account, false)
    get :index
    assert_match 'Welcome to Markcase', @response.body
  end

  test 'login redirects to the accounts page' do
    Settings.first.update_attribute(:single_account, false)
    post :create, params: { login: 'jennifer', password: 'password', remember_me: true }
    assert_redirected_to  user_path(username: 'jennifer')
  end
end

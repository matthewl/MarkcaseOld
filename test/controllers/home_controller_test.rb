# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'renders the first account for single tennants' do
    switch_to_single_tennant
    get :index
    assert_match 'ACME Literature', @response.body
    assert_match 'Just another literature website', @response.body
  end

  test 'renders the landing page' do
    get :index
    assert_match 'Welcome to Markcase', @response.body
  end

  test 'login redirects to the accounts page' do
    post :create, params: { login: 'jennifer', password: 'password', remember_me: true }
    assert_redirected_to  user_path(username: 'jennifer')
  end
end

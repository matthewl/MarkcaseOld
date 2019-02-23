# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test 'renders single account login' do
    switch_to_single_tennant
    get :new
    assert_match 'Please sign in', @response.body
  end 

  test 'new session redirects to landing page for multi account installations' do
    get :new
    assert_redirected_to home_index_path
  end
end
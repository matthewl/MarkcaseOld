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
    assert_match 'This is a landing page.', @response.body
  end
end

# frozen_string_literal: true

require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  test 'renders the bookmarks feed' do
    account = accounts(:jennifer)
    get :show, params: { username: account.login }
    assert_response :success
  end

  test 'renders the bookmarks feed when an auth token is supplied' do
    account = accounts(:jennifer)
    get :show, params: { username: account.login, auth_token: account.rss_auth_token }
    assert_response :success
  end

  test 'renders a 404 when a username could not be found' do
    get :show, params: { username: 'bob' }
    assert_response :not_found
  end

  test 'renders a 404 when an account is private' do
    get :show, params: { username: accounts(:drew).login }
    assert_response :not_found
  end
end

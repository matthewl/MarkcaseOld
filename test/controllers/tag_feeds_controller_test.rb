# frozen_string_literal: true

require 'test_helper'

class TagFeedsControllerTest < ActionController::TestCase
  def setup
    bookmark = bookmarks(:literature)
    bookmark.tag_list = "books, history"
    bookmark.save
  end

  test 'renders the tags feed' do
    account = accounts(:jennifer)
    get :show, params: { username: account.login, name: 'books' }
    assert_response :success
  end

  test 'renders the bookmarks by tag feed when an auth token is supplied' do
    account = accounts(:jennifer)
    get :show, params: { username: account.login, auth_token: account.rss_auth_token, name: 'books' }
    assert_response :success
  end

  test 'renders a 404 when a username could not be found' do
    get :show, params: { username: 'bob', name: 'books' }
    assert_response :not_found
  end

  test 'renders a 404 when an account is private' do
    get :show, params: { username: accounts(:drew).login, name: 'books' }
    assert_response :not_found
  end
end

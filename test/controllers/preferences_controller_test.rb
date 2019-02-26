# frozen_string_literal: true

require 'test_helper'

class PreferencesControllerTest < ActionController::TestCase
  setup do
    log_in_as(accounts(:jennifer))
  end

  test 'renders edit view' do
    get :edit
    assert_match 'Account', @response.body
  end

  test 'updates account preferences' do
    put :update, params: { account: { login: 'jenny' } }
    assert_equal 'jenny', Account.find_by(id: accounts(:jennifer).id).login
  end

  test 'update redirects to users bookmarks' do
    put :update, params: { account: { login: 'jenny' } }
    assert_redirected_to user_path(username: 'jenny')
  end

  test 'update redirects to root path for single tennants' do
    switch_to_single_tennant
    put :update, params: { account: { login: 'jenny'} }
    assert_redirected_to root_path
  end
end

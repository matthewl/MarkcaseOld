# frozen_string_literal: true

require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    log_in_as(accounts(:jennifer))
  end

  test 'renders the new page successfully' do
    get :new
    assert_response :success
  end

  test 'redirects to home page when single tennant' do
    switch_to_single_tennant
    get :new
    assert_redirected_to root_path
  end


  test 'deletes the account and all its bookmarks' do
    delete_params = { id: accounts(:jennifer).id }

    delete :destroy, params: delete_params

    assert Account.find(accounts(:drew).id)
    assert Bookmark.find_by(account_id: accounts(:drew).id)
    assert_nil Account.find_by(id: accounts(:jennifer).id)
    assert_nil Bookmark.find_by(account_id: accounts(:jennifer).id)
  end

  test 'delete redirects to home page' do
    delete_params = { id: accounts(:jennifer).id }

    delete :destroy, params: delete_params

    assert_redirected_to root_path
  end
end

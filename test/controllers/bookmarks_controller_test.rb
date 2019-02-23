# frozen_string_literal: true

require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  setup do
    log_in_as(accounts(:jennifer))
  end

  test 'renders the new form' do
    get :new

    assert_match 'Title', @response.body
    assert_match 'Url', @response.body
    assert_match 'Description', @response.body
    assert_match 'Tag list', @response.body
  end

  test 'creates a new bookmark' do
    new_params = {
      bookmark: {
        title: 'ACME Business',
        url: 'https://acme.business',
        description: 'Just another business website',
        tag_list: 'business,website'
      }
    }
    post :create, params: new_params

    new_bookmark = accounts(:jennifer).bookmarks.last
    assert_equal 'ACME Business', new_bookmark.title
    assert_equal 'https://acme.business', new_bookmark.url
    assert_equal 'Just another business website', new_bookmark.description
    assert_equal 'business,website', new_bookmark.tags_as_input
  end

  test 'create redirects to users bookmarks' do
    new_params = {
      bookmark: {
        title: 'ACME Business',
        url: 'https://acme.business',
        description: 'Just another business website',
        tag_list: 'business,website'
      }
    }
    post :create, params: new_params

    assert_redirected_to user_path(username: accounts(:jennifer).login)
  end

  test 'create redirects to the root path for single tennants' do
    switch_to_single_tennant
    new_params = {
      bookmark: {
        title: 'ACME Business',
        url: 'https://acme.business',
        description: 'Just another business website',
        tag_list: 'business,website'
      }
    }
    post :create, params: new_params

    assert_redirected_to root_path
  end

  test 'renders the edit form' do
    get :edit, params: { id: accounts(:jennifer).bookmarks.first.id }
  
    assert_match 'Title', @response.body
    assert_match 'Url', @response.body
    assert_match 'Description', @response.body
    assert_match 'Tag list', @response.body
  end

  test 'updates an existing bookmark' do
    edit_params = {
      id: bookmarks(:literature).id,
      bookmark: {
        title: 'ACME Literature v2',
        url: 'https://acme.literature',
        description: 'Just a literature website',
        tag_list: 'literature,website'
      }
    }
    put :update, params: edit_params

    new_bookmark = accounts(:jennifer).bookmarks.last
    assert_equal 'ACME Literature v2', new_bookmark.title
    assert_equal 'https://acme.literature', new_bookmark.url
    assert_equal 'Just a literature website', new_bookmark.description
    assert_equal 'literature,website', new_bookmark.tags_as_input
  end

  test 'update redirects to users bookmarks' do
    edit_params = {
      id: bookmarks(:literature).id,
      bookmark: {
        title: 'ACME Literature v2',
        url: 'https://acme.literature',
        description: 'Just a literature website',
        tag_list: 'literature,website'
      }
    }
    put :update, params: edit_params

    assert_redirected_to user_path(username: accounts(:jennifer).login)
  end

  test 'update redirects to root path for single tennants' do
    switch_to_single_tennant
    edit_params = {
      id: bookmarks(:literature).id,
      bookmark: {
        title: 'ACME Literature v2',
        url: 'https://acme.literature',
        description: 'Just a literature website',
        tag_list: 'literature,website'
      }
    }
    put :update, params: edit_params

    assert_redirected_to root_path
  end

  test 'deletes an existing bookmark' do
    delete_params = { id: bookmarks(:health).id }

    delete :destroy, params: delete_params

    assert_nil Bookmark.find_by(id: bookmarks(:health).id)
  end

  test 'delete redirects to users bookmarks' do
    delete_params = { id: bookmarks(:health).id }

    delete :destroy, params: delete_params

    assert_redirected_to user_path(username: accounts(:jennifer).login)
  end

  test 'delete redirects to root path for single tennants' do
    switch_to_single_tennant
    delete_params = { id: bookmarks(:health).id }

    delete :destroy, params: delete_params

    assert_redirected_to root_path
  end
end
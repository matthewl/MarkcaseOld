# frozen_string_literal: true

require 'test_helper'

class ImportControllerTest < ActionController::TestCase
  test 'redirects to the users bookmarks' do
    log_in_as(accounts(:jennifer))
    get :new
    
    assert_redirected_to user_path(username: accounts(:jennifer).login)
  end

  test 'renders the new form when imports feature is enabled' do
    log_in_as(accounts(:drew))
    get :new

    assert_match 'Select your import file', @response.body
  end

  test 'redirects to the users bookmarks when saved' do
    log_in_as(accounts(:drew))
    avatar_image = fixture_file_upload(Rails.root.join('test', 'fixtures', 'files', 'bookmarks.html'),'text/html')
    import_params = { account: { import_file: avatar_image } }
    
    post :create, params: import_params

    assert_redirected_to user_path(username: accounts(:drew).login)
  end
end

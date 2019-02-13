# frozen_string_literal :true
require 'application_system_test_case'

class UserBookmarksTest < ApplicationSystemTestCase
  test 'we can see a users bookmarks' do
    # Let's view a user's bookmarks
    visit public_user_url
    
    assert_text 'acme'
    assert_text 'stuff'
    assert_text 'ACME stuff'
    assert_text 'For all your needs!'

    # Let's try and view a private user's bookmarks
    visit private_user_url

    assert_no_text 'acme'
    assert_no_text 'roadrunner'
    assert_no_text 'ACME back catalogue'
    assert_no_text 'For all your road runner catching need!'
  end
end

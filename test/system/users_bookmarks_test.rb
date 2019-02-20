# frozen_string_literal :true
require 'application_system_test_case'

class UserBookmarksTest < ApplicationSystemTestCase
  test 'we can see a users bookmarks' do
    # Let's view a user's bookmarks
    visit user_url(username: accounts(:jennifer).login)

    assert_text 'ACME Health'
    assert_text 'Just another health website'
  end
end

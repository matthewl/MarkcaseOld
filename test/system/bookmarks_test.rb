# frozen_string_literal :true
require 'application_system_test_case'

class BookmarksTest < ApplicationSystemTestCase
  test 'the bookmark lifecycle' do
    # Let's login first.
    visit root_url
    fill_in 'inputLogin', with: 'jennifer'
    fill_in 'inputPassword', with: 'password'
    click_on 'Log in'

    # Add a bookmark.
    click_on 'New bookmark'

    fill_in 'bookmark_title', with: 'ACME stuff'
    fill_in 'bookmark_url', with: 'http://acme.net'
    fill_in 'bookmark_description', with: 'For all your needs!'
    fill_in 'bookmark_tag_list', with: 'acme stuff'
    click_on 'Save'

    assert_text 'acme'
    assert_text 'stuff'
    assert_text 'ACME stuff'
    assert_text 'For all your needs!'

    # Update a bookmark.
    bookmark = Bookmark.last

    click_link "edit_bookmark_#{bookmark.id}"

    fill_in 'bookmark_title', with: 'ACME back catalogue'
    fill_in 'bookmark_url', with: 'http://acme.net'
    fill_in 'bookmark_description', with: 'For all your road runner catching need!'
    fill_in 'bookmark_tag_list', with: 'acme roadrunner'
    click_on 'Save'

    assert_text 'acme'
    assert_text 'roadrunner'
    assert_text 'ACME back catalogue'
    assert_text 'For all your road runner catching need!'

    # Delete a bookmark
    accept_confirm do
      click_link "delete_bookmark_#{bookmark.id}"
    end

    assert_no_text 'acme'
    assert_no_text 'roadrunner'
    assert_no_text 'ACME back catalogue'
    assert_no_text 'For all your road runner catching need!'
  end
end

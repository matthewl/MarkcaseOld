# frozen_string_literal :true
require 'application_system_test_case'

class SetupTest < ApplicationSystemTestCase
  test 'setting up the application' do
    # Remove all test accounts, bookmarks and bundles.
    Account.first.destroy

    # Goto the root path.
    visit start_url

    # Fill in the setup form.
    fill_in 'account_login', with: 'jennifer'
    fill_in 'account_email', with: 'jennifer@acme.net'
    fill_in 'account_password', with: 'password'
    fill_in 'account_password_confirmation', with: 'password'
    click_on 'Create account'

    assert_selector '.btn-primary', text: 'New bookmark'

    # Let's add a bookmark.
    click_on 'New bookmark'

    fill_in 'bookmark_title', with: 'ACME stuff'
    fill_in 'bookmark_url', with: 'http://acme.net'
    fill_in 'bookmark_description', with: 'For all your needs!'
    fill_in 'bookmark_tags', with: 'acme stuff'
    click_on 'Save'

    assert_text 'acme'
    assert_text 'stuff'
    assert_text 'ACME stuff'
    assert_text 'For all your needs!'

    # And now the setup form is inaccessible.
    visit start_url

    assert_text 'acme'
    assert_text 'stuff'
    assert_text 'ACME stuff'
    assert_text 'For all your needs!'
  end
end

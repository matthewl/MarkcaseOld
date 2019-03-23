# frozen_string_literal :true
require 'application_system_test_case'

class RegistrationTest < ApplicationSystemTestCase
  test 'registering a user' do
    # Let's click the new account link
    visit root_url
    click_on 'Create your account'

    # Fill in our account details.
    fill_in 'account_login', with: 'ash'
    fill_in 'account_email', with: 'ash@acme.net'
    fill_in 'account_password', with: 'horsestaplebatterywindow'
    click_on 'Create account'

    # assert we can see our list of bookmarks
    assert_selector '.btn-primary', text: 'New bookmark'
  end
end

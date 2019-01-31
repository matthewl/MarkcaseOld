# frozen_string_literal :true
require 'application_system_test_case'

class PasswordResetTest < ApplicationSystemTestCase
  test 'the password reset lifecycle' do
    # Let's request a password reset first.
    visit login_url
    click_on 'Forgot your password?'

    # Add a bookmark.
    fill_in 'login', with: 'jennifer'
    click_on 'Reset password'

    # Visit the url from the email
    visit edit_password_reset_url(id: Account.find_by(login: 'jennifer').password_reset_token)
    fill_in 'account_password', with: 'password123'
    fill_in 'account_password_confirmation', with: 'password123'
    click_on 'Update password'

    # Let's try logging in now.
    visit login_url
    fill_in 'inputLogin', with: 'jennifer'
    fill_in 'inputPassword', with: 'password123'
    click_on 'Log in'

    assert_text 'ACME Health'
    assert_text 'Just another health website'
  end
end

require 'test_helper'

class PasswordResetControllerTest < ActionController::TestCase
  test 'new action responds with success' do
    get :new
    assert_response :success
  end

  test 'create action with valid login redirects to root' do
    post :create, params: { login: 'jennifer' }
    assert_redirected_to root_path
  end

  test 'create action with valid params notifies user of reset instructions' do
    post :create, params: { login: 'jennifer' }
    assert_equal I18n.t('password.reset_sent'), flash[:notice]
  end

  test 'create action with invalid login redirects to root' do
    post :create, params: { email: 'matthew' }
    assert_redirected_to root_path
  end

  test 'create action with invalid login has a blank notification' do
    post :create, params: { email: 'matthew' }
    refute flash[:notice]
  end

  test 'edit action responds with success' do
    account = accounts(:jennifer)
    account.send_password_reset('localhost:3000')

    get :edit, params: { id: account.password_reset_token }

    assert_response :success
  end

  test 'update action with an invalid password renders the edit form' do
    account = accounts(:jennifer)
    account.send_password_reset('localhost:3000')
    account_params = { password: ', password_confirmation: ' }

    put :update, params: { id: account.password_reset_token, account: account_params }

    assert_select 'h2', 'Reset your password'
  end

  test 'update action with an expired password token redirects' do
    account = accounts(:jennifer)
    account.send_password_reset('localhost:3000')
    account.update_attribute(:password_reset_sent_at, 3.hours.ago)
    account_params = { password: 'password', password_confirmation: 'password' }

    put :update, params: { id: account.password_reset_token, account: account_params }

    assert_redirected_to new_password_reset_path
    assert_equal I18n.t('password.reset_expired'), flash[:alert]
  end

  test 'update action with a valid password redirects to root' do
    account = accounts(:jennifer)
    account.send_password_reset('localhost:3000')
    account_params = {
      password: 'redpanda',
      password_confirmation: 'redpanda'
    }

    put :update, params: { id: account.password_reset_token, account: account_params }

    assert_redirected_to root_path
    assert_equal I18n.t('password.reset'), flash[:notice]
    assert Account.find(account.id).authenticate('redpanda')
  end
end

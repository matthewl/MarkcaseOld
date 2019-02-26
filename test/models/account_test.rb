# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'login is unique' do
    account =
      Account.new(
        login: 'matthew',
        email: 'matthew@acme.net',
        password: 'password'
      )
    assert account.valid?

    account =
      Account.new(
        login: 'jennifer',
        email: 'jen@acme.net',
        password: 'password'
      )
    refute account.valid?
  end

  test 'email is unique' do
    account =
      Account.new(
        login: 'matthew',
        email: 'matthew@acme.net',
        password: 'password'
      )
    assert account.valid?

    account =
      Account.new(
        login: 'jen',
        email: 'jennifer@acme.net',
        password: 'password'
      )
    refute account.valid?
  end
end

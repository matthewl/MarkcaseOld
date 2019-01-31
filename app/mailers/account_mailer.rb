class AccountMailer < ApplicationMailer
  def password_reset(account, host)
    @account = account
    @host = host
    mail to: account.email, subject: 'Password reset'
  end
end

class PasswordResetController < ApplicationController
  layout 'blank'
  skip_before_action :verify_account
  before_action :find_account_by_reset_token, only: %i[edit update]

  def new; end

  def create
    account = Account.find_by(login: params[:login])
    if account
      account.send_password_reset(request.host_with_port)
      redirect_to root_path, notice: t('password.reset_sent')
    else
      redirect_to root_path
    end
  end

  def edit; end

  def update
    if @account.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: t('password.reset_expired')
    elsif valid_password? && @account.update_attributes(password_params)
      redirect_to root_url, notice: t('password.reset')
    else
      render :edit
    end
  end

  private

  def find_account_by_reset_token
    @account = Account.find_by(password_reset_token: params[:id])
  end

  def password_params
    params.require(:account).permit(:password, :password_confirmation)
  end

  def valid_password?
    return false if params[:account][:password].blank?
    return false if params[:account][:password_confirmation].blank?
    return false unless passwords_match?

    true
  end

  def passwords_match?
    params[:account][:password] == params[:account][:password_confirmation]
  end
end

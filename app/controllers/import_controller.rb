# frozen_string_literal: true

class ImportController < AuthenticatedController

  def new
    FT.with(:importing_bookmarks, account_id: current_user.id) do
      render :new
    end

    redirect_to user_path(username: current_account.login)
  end
  
  def create
    @account = current_account
    if @account.update_attributes(import_params)
      redirect_to user_path(username: current_account.login)
    else
      render :new
    end
  end

  private

  def bookmark_params
    params.require(:account).permit(:import_file)
  end
end
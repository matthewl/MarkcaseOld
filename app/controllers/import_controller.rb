# frozen_string_literal: true

class ImportController < AuthenticatedController

  def new
    FT.with(:importing_bookmarks, account_id: current_account.id) do
      @account = current_account
      @tags = find_tags_for_cloud(current_account)
      return render :new
    end

    redirect_to users_bookmarks_path
  end
  
  def create
    @account = current_account
    if @account.update_attributes(import_params)
      redirect_to users_bookmarks_path
    else
      render :new
    end
  end

  private

  def import_params
    params.require(:account).permit(:import_file)
  end

  def users_bookmarks_path
    user_path(username: current_account.login)
  end
end
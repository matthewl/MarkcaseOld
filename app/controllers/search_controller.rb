# frozen_string_literal: true

class SearchController < AuthenticatedController
  include Pagy::Backend

  def show
    @account = current_account
    @tags = @account.bookmarks.counted_tags
    @pagy, @bookmarks = pagy(@account.bookmarks.search(params[:query]))
  end
end
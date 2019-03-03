# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  def find_tags_for_cloud(account)
    account.bookmarks.counted_tags
  end
end

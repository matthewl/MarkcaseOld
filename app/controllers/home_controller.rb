# frozen_string_literal: true

class HomeController < ApplicationController
  include Pagy::Backend
  skip_before_action :verify_account

  def index
    if Settings.first.single_account?
      @tags = find_tags_for_cloud
      @pagy, @bookmarks =
        if current_account
          pagy(Bookmark.all.order('created_at DESC'))
        else
          pagy(Bookmark.shared.order('created_at DESC'))
        end
      render :single
    else
      render :landing, layout: 'blank'
    end
  end
end

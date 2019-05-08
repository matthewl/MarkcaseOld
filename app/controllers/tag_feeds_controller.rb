# frozen_string_literal: true

class TagFeedsController < ApplicationController
  before_action :ensure_account_accessible

  def show
    if accessible_account?
      @bookmarks = account.bookmarks.tagged_with(params[:name]).for_feeds
      respond_to { |format| format.rss { render layout: false } }
    else
      render_feed_not_found
    end
  end

  private

  def account
    @account ||= find_account
  end

  def accessible_account?
    params['auth_token'].present? || account.public_site?
  end

  def find_account
    if params['auth_token'].present?
      Account.find_by(
        login: params['username'],
        rss_auth_token: params['auth_token']
      )
    else
      Account.find_by(login: params['username'])
    end
  end

  def ensure_account_accessible
    return unless account.nil? || !account.public_site?
    render_feed_not_found
  end

  def render_feed_not_found
    render json: { message: t('feed.not_found') }, status: :not_found
  end
end

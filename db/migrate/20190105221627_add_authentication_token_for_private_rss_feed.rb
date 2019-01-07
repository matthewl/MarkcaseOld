class AddAuthenticationTokenForPrivateRssFeed < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :rss_auth_token, :string
  end
end

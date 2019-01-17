class AddAccountIdToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_reference :bookmarks, :account, foreign_key: true
  end
end

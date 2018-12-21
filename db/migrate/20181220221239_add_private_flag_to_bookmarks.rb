class AddPrivateFlagToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :hidden, :boolean, default: false
  end
end

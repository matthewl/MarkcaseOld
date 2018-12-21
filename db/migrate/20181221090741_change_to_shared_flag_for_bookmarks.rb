class ChangeToSharedFlagForBookmarks < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookmarks, :hidden
    add_column :bookmarks, :shared, :boolean, default: true
  end
end

class AddTagsToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :tags, :string, array: true
  end
end

class RenameTagsToOldTags < ActiveRecord::Migration[5.2]
  def change
    rename_column(:bookmarks, :tags, :old_tags)
  end
end

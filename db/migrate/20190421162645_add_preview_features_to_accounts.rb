class AddPreviewFeaturesToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :preview_features, :boolean, default: false
  end
end

class ChangeLoginToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :accounts, :login, :string, null: false
  end
end

class AddLogintoAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :login, :string
  end
end

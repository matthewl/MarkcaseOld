class AddPublicFlgagToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :public_site, :boolean, default: false
  end
end

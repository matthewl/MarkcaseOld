class CreateBundles < ActiveRecord::Migration[5.2]
  def change
    create_table :bundles do |t|
      t.references :account, index: true
      t.string :name
      t.text :tags
      t.boolean :shared, default: true
      t.timestamps
    end
  end
end

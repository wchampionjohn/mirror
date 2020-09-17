class CreateAdStores < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_stores do |t|
      t.integer :ad_id
      t.integer :store_id

      t.timestamps
    end
    add_index :ad_stores, :ad_id
    add_index :ad_stores, :store_id
  end
end

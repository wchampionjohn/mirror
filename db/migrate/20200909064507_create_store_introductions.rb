class CreateStoreIntroductions < ActiveRecord::Migration[6.0]
  def change
    create_table :store_introductions do |t|
      t.integer :store_id
      t.integer :menu_type, limit: 2
      t.string :attachment
      t.timestamps
    end

    add_index :store_introductions, :store_id
  end
end

class CreateAgeGroupStores < ActiveRecord::Migration[6.0]
  def change
    create_table :age_group_stores do |t|
      t.integer :age_group_id
      t.integer :store_id

      t.timestamps
    end

    add_index :age_group_stores, :age_group_id
    add_index :age_group_stores, :store_id
  end
end

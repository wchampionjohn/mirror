class CreateStoreBusinessHours < ActiveRecord::Migration[6.0]
  def change
    create_table :store_business_hours do |t|
      t.integer :day, limit: 2
      t.boolean :is_openness
      t.time :start_time
      t.time :end_time
      t.integer :store_id
      t.timestamps
    end

    add_index :store_business_hours, :store_id
    add_index :store_business_hours, :is_openness
  end
end

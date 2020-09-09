class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.integer :city_id
      t.integer :area_id
      t.string :contact_name
      t.string :contact_phone_number
      t.integer :devices_count
      t.string :email
      t.integer :commission
      t.integer :gender, limit: 2
      t.integer :contract_attachment
      t.string :note

      t.timestamps
    end

    add_index :stores, :city_id
    add_index :stores, :area_id
    add_index :stores, :gender

  end
end

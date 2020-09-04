class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :mac
      t.string :token
      t.integer :store_id
      t.boolean :test_mode, limit: 1
      t.string :note
      t.datetime :last_report_time

      t.timestamps
    end

    add_index :devices, :store_id

  end
end

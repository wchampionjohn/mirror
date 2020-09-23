class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.integer :position
      t.string :icon
      t.boolean :is_active
      t.integer :gender, limit: 2

      t.timestamps
    end
    add_index :channels, :gender
    add_index :channels, :position
    add_index :channels, :is_active
  end
end

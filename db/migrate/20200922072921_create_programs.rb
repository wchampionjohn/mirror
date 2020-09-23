class CreatePrograms < ActiveRecord::Migration[6.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :channel_id
      t.integer :seconds
      t.boolean :is_active
      t.string :video
      t.integer :position
      t.integer :gender, limit: 2

      t.timestamps
    end

    add_index :programs, :channel_id
    add_index :programs, :gender
    add_index :programs, :is_active
    add_index :programs, :position
  end
end

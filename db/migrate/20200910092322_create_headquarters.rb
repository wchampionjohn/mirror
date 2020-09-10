class CreateHeadquarters < ActiveRecord::Migration[6.0]
  def change
    create_table :headquarters do |t|
      t.integer :stores_count
      t.string :name
      t.integer :commission
      t.timestamps
    end
  end
end

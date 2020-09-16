class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.string :name
      t.integer :status, limit: 4
      t.integer :seconds
      t.date :start_at
      t.date :end_at
      t.string :material
      t.string :banner
      t.integer :category_id
      t.integer :category_item_id
      t.integer :advertiser_id
      t.decimal :budget, limit: 2, precision: 10, scale: 2
      t.integer :ad_type, limit: 2
      t.integer :gender, limit: 2
      t.string :scanning_link
      t.decimal :cpv, limit: 2, precision: 10, scale: 2
      t.decimal :cpm, limit: 2, precision: 10, scale: 2
      t.integer :impressions
      t.integer :views
      t.integer :viewers, comment: '可以辨識出人臉數據的觀看者'

      t.timestamps
    end

    add_index :ads, :status
    add_index :ads, :gender
    add_index :ads, :ad_type
    add_index :ads, :start_at
    add_index :ads, :end_at
  end
end

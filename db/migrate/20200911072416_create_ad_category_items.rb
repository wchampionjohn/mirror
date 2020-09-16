class CreateAdCategoryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_category_items do |t|
      t.string :name
      t.integer :ad_id
      t.integer :category_id

      t.timestamps
    end
  end
end

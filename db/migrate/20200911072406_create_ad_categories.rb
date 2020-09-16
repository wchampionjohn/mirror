class CreateAdCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_categories do |t|
      t.string :name
      t.integer :ad_id

      t.timestamps
    end
  end
end

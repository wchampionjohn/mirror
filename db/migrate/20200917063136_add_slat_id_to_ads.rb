class AddSlatIdToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :slat_id, :integer
    add_index :ads, :slat_id
  end
end

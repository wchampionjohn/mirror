class AddMd5ToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :material_md5, :string
    add_column :ads, :material_size, :integer
    add_column :ads, :banner_md5, :string
    add_column :ads, :banner_size, :integer
  end
end

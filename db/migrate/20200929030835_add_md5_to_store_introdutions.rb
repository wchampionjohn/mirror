class AddMd5ToStoreIntrodutions < ActiveRecord::Migration[6.0]
  def change
    add_column :store_introductions, :md5, :string
  end
end

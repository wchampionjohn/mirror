class CreateStoreIntroductions < ActiveRecord::Migration[6.0]
  def change
    create_table :store_introductions do |t|

      t.timestamps
    end
  end
end

class AddHeadquoterIdToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :headquarter_id, :integer
    add_index :stores, :headquarter_id
  end
end

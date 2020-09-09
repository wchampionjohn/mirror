class AddedAvailableToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :available, :boolean
  end
end

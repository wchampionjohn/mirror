class AddSnToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :sn, :string
  end
end

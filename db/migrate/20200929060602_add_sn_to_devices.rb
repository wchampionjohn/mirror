class AddSnToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :sn, :string
    add_column :devices, :version, :string
  end
end

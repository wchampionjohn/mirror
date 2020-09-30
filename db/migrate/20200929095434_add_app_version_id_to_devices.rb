class AddAppVersionIdToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :app_version_id, :integer
    add_index :devices, :app_version_id
  end
end

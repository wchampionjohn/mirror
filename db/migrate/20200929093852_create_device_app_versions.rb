class CreateDeviceAppVersions < ActiveRecord::Migration[6.0]
  def change
    create_table :device_app_versions do |t|
      t.string :number
      t.text :note

      t.timestamps
    end
  end
end

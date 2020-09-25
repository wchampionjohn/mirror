class AddScreenshotIdToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :screenshot_id, :integer
    add_index :programs, :screenshot_id
  end
end

class AddScreenshotToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :screenshot, :string
  end
end

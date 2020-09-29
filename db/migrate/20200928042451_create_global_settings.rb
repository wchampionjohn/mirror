class CreateGlobalSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :global_settings do |t|
      t.integer :program_length
      t.integer :lowest_ads_amount

      t.timestamps
    end
  end
end

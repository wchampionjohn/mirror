class CreateProgramScreenshots < ActiveRecord::Migration[6.0]
  def change
    create_table :program_screenshots do |t|
      t.string :image
      t.integer :program_id
      t.datetime :created_at
    end

    add_index :program_screenshots, :program_id
  end
end

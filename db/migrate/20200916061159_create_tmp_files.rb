class CreateTmpFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :tmp_files do |t|
      t.string :code
      t.string :file
      t.string :model
      t.string :column
      t.integer :size
      t.string :md5

      t.timestamps
    end
  end
end

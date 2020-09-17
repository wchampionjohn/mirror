class CreateSlats < ActiveRecord::Migration[6.0]
  def change
    create_table :slats do |t|
      t.string :name

      t.timestamps
    end
  end
end

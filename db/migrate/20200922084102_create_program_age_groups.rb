class CreateProgramAgeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :program_age_groups do |t|

      t.integer :age_group_id
      t.integer :program_id

      t.timestamps
    end

    add_index :program_age_groups, :age_group_id
    add_index :program_age_groups, :program_id
  end
end

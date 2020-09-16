class CreateAdAgeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_age_groups do |t|

      t.integer :age_group_id
      t.integer :ad_id

      t.timestamps
    end

    add_index :ad_age_groups, :age_group_id
    add_index :ad_age_groups, :ad_id
  end
end

class CreateChannelAgeGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :channel_age_groups do |t|

      t.integer :age_group_id
      t.integer :channel_id

      t.timestamps
    end

    add_index :channel_age_groups, :age_group_id
    add_index :channel_age_groups, :channel_id
  end
end

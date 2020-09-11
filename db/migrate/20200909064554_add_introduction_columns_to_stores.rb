class AddIntroductionColumnsToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :is_information_menu_on, :boolean
    add_column :stores, :is_service_menu_on, :boolean
    add_column :stores, :information_menu_alias, :string
    add_column :stores, :service_menu_alias, :string
    add_column :stores, :information_menu_icon, :string
    add_column :stores, :service_menu_icon, :string
  end
end

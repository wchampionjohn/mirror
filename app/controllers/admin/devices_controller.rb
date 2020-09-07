class Admin::DevicesController < Admin::AppsController

  include Crudable

  private
  def permitted_attributes
    [
      :name, :mac, :store_id, :test_mode, :note
    ]
  end

  def filter_columns
    ['name']
  end

end

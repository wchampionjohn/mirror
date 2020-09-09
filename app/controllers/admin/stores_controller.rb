class Admin::StoresController < Admin::AppsController

  include Crudable

  before_action only: [:new] do
    @area_options = []

    Store::BusinessHour::days.keys.each do |day|
      current_object.business_hours.build(
        day: day
      )
    end
  end

  before_action only: [:edit, :update] do
    current_object.current_step = params[:step].to_i if params[:step]
    @area_options = Area.where(city_id: current_object.city_id).formated_options

    @icon_options = Store::ICONS.map do |text, icon_class|
      [ text, icon_class, {'data-icon' => icon_class } ]
    end
  end

  def new; end

  def edit; end

  private
  def permitted_attributes
    [
      :name, :area_id, :city_id, :address
    ]
  end

  def filter_columns
    ['name']
  end

  def current_collection
    default_scope.includes([:city, :area])
  end
  def permitted_attributes
    [
     :name, :address, :area_id, :city_id, :commission,
     :contact_phone_number, :contact_name, :email, :gender,
     :turn_on_service_menu, :turn_on_information_menu,
     :service_menu_alias, :service_menu_icon,
     :information_menu_alias, :information_menu_icon,
     business_hours_attributes: [
       :id, :day, :is_openness, :start_time, :end_time
     ],
     age_group_ids: []
    ]
  end

  def action_after_create
    edit_admin_store_path(Store.last.id, step: 2)
  end
end

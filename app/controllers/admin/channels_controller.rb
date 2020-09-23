class Admin::ChannelsController < Admin::AppsController

  include Crudable

  before_action only: [:index] do
    @sub_title = '頻道'
  end

  before_action only: [:new, :create, :edit, :update] do
    @icon_options = Settings.icons.map do |text, icon_class|
      [ text, icon_class, {'data-icon' => icon_class } ]
    end
  end

  def filter_columns
    ['name']
  end

  private

  def current_collection
    default_scope.includes(:programs)
  end

  def permitted_attributes
    [:name, :icon, :position, :is_active]
  end

end

class Admin::GlobalSettingsController < Admin::AppsController
  include Crudable

  def index
    redirect_to action_after_update
  end


  private
  def permitted_attributes
    [
      :program_length, :lowest_ads_amount
    ]
  end

  def  action_after_update
    edit_admin_global_setting_path GlobalSetting.current
  end
end

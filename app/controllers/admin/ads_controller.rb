class Admin::AdsController < Admin::AppsController

  include Crudable
  include AdHelpers

  def create
    current_object.attributes = object_params

    if current_object.save
      redirect_to action_after_create, :flash => {:success => '已完成新增'}
    else
      flash[:alert] = '新增時發生以下錯誤，請修正後再重新嘗試'
      render new_template
    end
  end

  private
  def permitted_attributes
    [
     :name, :advertiser_id, :advertiser_name,
     :budget, :cpv, :cpm, :category_id,
     :category_item_id, :seconds, :ad_type, :start_at, :end_at,
     :scanning_link,
     age_group_ids: []
    ]
  end

  def filter_columns
    ['name']
  end

end

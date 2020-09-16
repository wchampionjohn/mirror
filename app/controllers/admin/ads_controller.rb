class Admin::AdsController < Admin::AppsController

  include Crudable
  include AdHelpers

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

class Admin::AuditingAds::WaitsController < ApplicationController
  def create
    ad = Ad.find(params[:id])

    if ad.is_default?
      ad.update_column :state, :waiting
    else
      ad.ready!
    end

    redirect_to admin_ads_path, flash: { success: 'approve successfully' }
  end
end

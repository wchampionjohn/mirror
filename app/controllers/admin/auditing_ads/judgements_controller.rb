class Admin::AuditingAds::JudgementsController < Admin::AppsController

  def create
    ad = Ad.find params[:id]

    begin
      ad.approve!
      #message = current_admin.ad_notification_message(ad, :approve)
      #Ad::NotificationJob.perform_now(message)
    rescue ::AASM::InvalidTransition => e
      flash_message = { alert: '無法審核' }
    else
      flash_message = { success: '已通過審核 !' }
    end

    redirect_to admin_auditing_ads_path, flash:  flash_message
  end


  def destroy
    ad = Ad.find params[:id]
    ad.disapprove!

    redirect_to admin_auditing_ads_path, flash: { success: '已退回審核' }
  end

end

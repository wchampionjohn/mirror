class Admin::Ads::FilesController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    ad = Ad.find params[:ad_id]
    file_type = params[:file_type]

    ad.update_attribute(file_type, params[:file])
    ad.create_screenshot if file_type == 'material'

    render json: ad.send(file_type).url, status: :ok
  end

end

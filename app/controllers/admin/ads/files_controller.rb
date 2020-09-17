class Admin::Ads::FilesController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    ad = Ad.find params[:ad_id]
    file_type = params[:file_type]

    ad.update_attributes(
      "#{file_type}" => params[:file],
     "#{file_type}_size" => File.size(params[:file].path),
      "#{file_type}_md5": Digest::MD5.hexdigest(params[:file].read)
    )

    response_info = ad.send("#{file_type}_info")
    response_info[:size] = response_info[:size].to_filesize

    render json: response_info, status: :ok
  end

end

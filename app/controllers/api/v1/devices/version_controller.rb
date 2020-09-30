class Api::V1::Devices::VersionController < Api::V1::ApiController

  def create
    app_version = ::Device::AppVersion.find_or_create_by number: device_params[:app_version]
    if current_device.update_column :app_version_id, app_version.id
      render json: {}, status: 200
    else
      render json: '新增失敗', status: 500
    end
  end

  private
  def device_params
    @storage ||= JSON.parse(request.body.read).symbolize_keys.slice(*[:app_version])
  end

end

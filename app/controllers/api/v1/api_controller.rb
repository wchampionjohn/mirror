class Api::V1::ApiController < Api::ApplicationController
  # before_action :authorize_api_clients
  include Api::ErrorHandler

  rescue_from 'ActiveRecord::RecordInvalid' do  |exception|
    render json: { message: exception.message }, status: 422
  end

  private

  def current_device
    @device = ::Device.find_by_mac params[:key]
  end

  def device_not_found
    render_404 message: "Device not found" and return unless @device
  end

  def authenticate_access_token!
    raise Errors::Unauthorized unless authenticate_pass?
  end

  def authenticate_pass?
    if request.headers['token'] != Settings.access_token
      logger.debug 'api access token比對不正確'
      false
    else
      true
    end
  end

end

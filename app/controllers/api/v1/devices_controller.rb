class Api::V1::DevicesController < Api::V1::ApiController
  def show
    serialized_device = Api::DeviceLaunchSerializer.new(current_device).serializable_hash
    device_attributes = serialized_device[:data][:attributes]
    render json: device_attributes, status: 200
  end
end

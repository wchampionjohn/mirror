class Api::V1::Devices::TouchController < Api::V1::ApiController

  def create
    current_device.touch(:last_report_time)
    head :no_content
  end

end

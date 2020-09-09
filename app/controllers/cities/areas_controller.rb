class Cities::AreasController < ApplicationController
  def index
    areas = Area.where(city_id: params[:id]).formated_options
    render json: { data: areas }, status: :ok
  end
end

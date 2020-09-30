class Api::V1::Devices::AdsController < ApplicationController
  def index
    ads = Ad.running
    serialized_programs = Api::AdSerializer.new(ads).serializable_hash

    render json: serialized_programs[:data].map { |program| program[:attributes] }, status: 200
  end

end

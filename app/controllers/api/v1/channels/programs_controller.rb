class Api::V1::Channels::ProgramsController < ApplicationController

  def index
    channel = Channel.find params[:channel_id]
    programs = channel.programs.active.includes(:current_screenshot)

    serialized_programs = Api::ProgramSerializer.new(programs).serializable_hash

    render json: serialized_programs[:data].map { |program| program[:attributes] }, status: 200
  end

end

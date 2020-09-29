class Admin::Channels::ProgramsController < Admin::AppsController

  skip_before_action :verify_authenticity_token

  def index
    @current_breadcrumb = { 'name' => '節目', 'link' => admin_channel_programs_path(params[:channel_id]) }
    channel = Channel.find params[:channel_id]
    @channel = channel
    @programs = ProgramSerializer.new(channel.programs.includes(:screenshots).order(:position))
      .serializable_hash[:data]
      .map { |hash| hash[:attributes] }
  end

  def create
    channel = Channel.find params[:channel_id]

    original_filename = params[:file].original_filename
    base_filename = File.basename(original_filename, File.extname(original_filename))

    program = channel.programs.build(
      video: params[:file],
      name: base_filename
    )

    if program.save
      resopnse_file = ProgramSerializer.new(program).serializable_hash
      render json: {
        program: resopnse_file[:data][:attributes].to_json
      }, status: :ok
    else
      render json: { errors: program.errors.full_messages.last }, status: :unprocessable_entity
    end
  end

  def update
    channel = Channel.find params[:channel_id]
    program = channel.programs.find params[:id]

    program.update(program_params)
    render json: {}, status: :ok
  end

  def rearrange
    channel = Channel.find params[:channel_id]
    new_order = params[:ids]
    programs = channel.programs.active.to_a.compact

    rearranged_programs = new_order.map do |program_id|
      programs.find { |program| program.id == program_id }
    end

    rearranged_programs.compact.each_with_index.map do |program, position|
      program.position = position
      program.save!
    end

    render json: {}, status: :ok
  end

  def suspend
    channel = Channel.find params[:channel_id]
    channel.programs.find(params[:id]).suspend
    render json: {}, status: :ok
  end

  def recover
    channel = Channel.find params[:channel_id]
    channel.programs.find(params[:id]).recover
    render json: {}, status: :ok
  end

  def destroy
    channel = Channel.find params[:channel_id]
    channel.programs.find(params[:id]).destroy
    render json: {}, status: :ok
  end

  def screenshot
    program = Program.find(params[:id])
    screenshot = program.screenshots.build image: params[:file]

    screenshot.save
    program.update_column :screenshot_id, screenshot.id

    render json: screenshot.formated_attributes, status: :ok
  end

  private
  def program_params
    @program ||= ActionController::Parameters.new(
      JSON.parse(request.body.read).symbolize_keys
    ).permit(:name, :seconds, :screenshot_id, screenshot_ids: [])
  end

  def rearranged_params
    @rearranged ||= ActionController::Parameters.new(
      JSON.parse(request.body.read).symbolize_keys
    ).permit(:ids)
  end

end

class Program::AutomaticSetVideoPlayTimeJob < ApplicationJob
  queue_as :program

  def perform(id)
    program = Program.find id

    file = program.display_file.file

    video = if file.kind_of? CarrierWave::SanitizedFile
              file.file
            elsif file.kind_of? CarrierWave::Storage::Fog::File
              file.url
            end

    seconds_of_video = FFMPEG::Movie.new(video).duration
    program.update_column(:seconds, seconds_of_video)

    logger.debug "program #{program.name} (id: #{program.id}) updated seconds to #{seconds_of_video}"
  end
end

class ScreenshotService

  def initialize(path, second)
    @path, @second = path, second
  end

  def perform
    movie = FFMPEG::Movie.new(Ad.last.material.file.file)
    temp_path = Rails.root.join('tmp', 'screenshot.jpg').to_s
    movie.screenshot(temp_path, seek_time: @second)
  end

end

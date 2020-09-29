class Api::ProgramSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id , :name, :seconds, :video_md5

  attributes :cover_photo do |object|
    object.current_screenshot.image.try(:url)
  end

  attributes :video do |object|
    object.video.url
  end

end

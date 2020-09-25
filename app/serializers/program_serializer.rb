class ProgramSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :seconds, :updated_at, :is_active, :position

  attributes :updated_at do |object|
    object.updated_at.to_s
  end

  attributes :video_url do |object|
    object.video.url
  end

  attributes :screenshots do |object|
    object.screenshots.map &:formated_attributes
  end

  attributes :current_screenshot do |object|
    object.current_screenshot.try(:formated_attributes) || { url: '' }
  end

end

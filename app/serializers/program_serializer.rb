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
    current_screenshot = object.screenshots.find { |screenshot| screenshot.id == object.screenshot_id }

    if current_screenshot
      current_screenshot.formated_attributes
    else
    { id: nil, url: '' }
    end
  end

end

class AdSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :unit_price, :status

  attributes :unit_price do |object|
    if object.unit_price.blank?
      '免費'
    else
      object.unit_price.join(' ')
    end
  end

  attributes :period do |object|
    "#{object.start_at} ~ #{object.end_at}"
  end

  attributes :screenshot do |object|
    object.screenshot.url
  end

  attributes :material do |object|
    object.material.url
  end

  attributes :ad_type do |object|
    object.class.human_attribute_name("ad_type.#{object.ad_type}")
  end

end

class AuditingAdSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :status
  attributes :impressions, :views, :seconds, :scanning_link

  attributes :unit_price do |object|
    if object.unit_price.blank?
      '-'
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

  attributes :status_text do |object|
    object.class.human_attribute_name("status.#{object.status}")
  end

  attributes :advertiser do |object|
    object.advertiser.name
  end

  attributes :category do |object|
    "#{object.category.name} - #{object.category_item.name}"
  end

  attributes :banner do |object|
    object.banner.url
  end
end

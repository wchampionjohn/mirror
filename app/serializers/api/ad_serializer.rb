class Api::AdSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :scanning_link
  attributes :seconds, :advertiser_id
  attributes :ad_type

  attributes :material do |object|
    object.material.url
  end

  attributes :material_md5

  attributes :banner do |object|
    object.banner.url
  end

  attributes :target_audience do |object|
    if object.precise?
      {
        gender: object.gender,
        ages: object.age_groups.map(&:group)
      }
    end
  end

end

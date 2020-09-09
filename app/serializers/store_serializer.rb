class StoreSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :full_area
  attributes :devices do |object|
    0
  end

  attributes :is_installed do |object|
    object.installed?
  end
end

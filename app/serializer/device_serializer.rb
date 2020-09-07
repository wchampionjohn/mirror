class DeviceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :mac
end

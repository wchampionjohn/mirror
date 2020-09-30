class DeviceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :mac
  attributes :out_of_service_minutes

  attributes :last_report_time do |object|
    object.last_report_time.to_s
  end

  attributes :last_report_time_words do |object|
    ActionController::Base.helpers.time_ago_in_words(object.last_report_time)
  end

end

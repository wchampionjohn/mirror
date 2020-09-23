class ChannelSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :position, :icon, :updated_at, :is_active

  attributes :programs do |object|
    object.programs.size
  end

  attributes :last_updated_at do |object|
    object.updated_at.to_s
  end

  attributes :seconds do |object|
    object.programs.active.reduce(0) do |accumulator, program|
      accumulator += program.seconds
    end
  end

end

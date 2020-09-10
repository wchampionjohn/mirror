class Store::IntrodutionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :menu_type

  attributes :attachment_url do |object|
    object.attachment.url
  end
end

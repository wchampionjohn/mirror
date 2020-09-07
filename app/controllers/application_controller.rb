class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :null_session

  def collection_json(records, serializer, options = {})
    serialized_hashes = serializer.new(records, options).serializable_hash
    serialized_hashes[:data].map! { |hash| hash[:attributes] }

    if self.respond_to?(:pagination)
      serialized_hashes.merge(pagination(records))
    else
      serialized_hashes
    end
  end

  def layout_by_resource
    if request.xhr?
      false
    else
      devise_controller? ? 'devise' : 'admin'
    end
  end

end

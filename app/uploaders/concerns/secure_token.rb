module SecureToken
  extend ActiveSupport::Concern

   protected
   def secure_token(length=16)
     var = :"@#{mounted_as}_secure_token"
     model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
   end
end


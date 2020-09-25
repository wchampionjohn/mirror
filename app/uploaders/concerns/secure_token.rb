module SecureToken
  extend ActiveSupport::Concern

   def filename
     "#{secure_token}.#{file.extension.downcase}" if original_filename.present?
   end

   protected
   def secure_token(length=16)
     var = :"@#{mounted_as}_secure_token"
     model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
   end
end


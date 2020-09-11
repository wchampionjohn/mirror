CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider     = 'fog/google'
    config.fog_public = true
    config.fog_credentials  = {
      provider:                         'Google',
      google_storage_access_key_id:     ENV['GOOGLE_STORAGE_ACCESS_KEY_ID'],
      google_storage_secret_access_key: ENV["GOOGLE_STORAGE_SECRET_ACCESS_KEY"],
      path_style: true
    }
    config.fog_directory    = 'cdn_mirror_solmate_cc'
    config.storage          = :fog
  else
    config.storage = :file
  end
end

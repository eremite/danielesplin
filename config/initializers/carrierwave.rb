CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'Google',
    google_storage_access_key_id: ENV['FOG_KEY'] || '',
    google_storage_secret_access_key: ENV['FOG_SECRET'] || '',
  }
  config.fog_directory = ENV['FOG_BUCKET'] || ''
end

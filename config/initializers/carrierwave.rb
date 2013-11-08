CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'Google',
    google_storage_access_key_id: Figaro.env.fog_key.to_s,
    google_storage_secret_access_key: Figaro.env.fog_secret.to_s,
  }
  config.fog_directory = Figaro.env.fog_bucket.to_s
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.secrets.fog_key.to_s,
    aws_secret_access_key: Rails.application.secrets.fog_secret.to_s,
  }
  config.fog_directory = Rails.application.secrets.fog_bucket.to_s
  config.cache_dir = 'system/tmp'
  config.fog_attributes = { 'Cache-Control' => "public, max-age=#{1.year.to_i}" }
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['FOG_KEY'].to_s,
    aws_secret_access_key: ENV['FOG_SECRET'].to_s,
  }
  config.storage :fog
  config.fog_directory = ENV['FOG_BUCKET'].to_s
  config.cache_dir = 'system/tmp'
  config.fog_attributes = { 'Cache-Control' => "public, max-age=#{1.year.to_i}" }
end

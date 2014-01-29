CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Figaro.env.fog_key.to_s,
    aws_secret_access_key: Figaro.env.fog_secret.to_s,
  }
  config.fog_directory = Figaro.env.fog_bucket.to_s
end

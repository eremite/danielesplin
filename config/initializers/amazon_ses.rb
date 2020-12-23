ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base, {
  access_key_id: ENV['SES_KEY'].to_s,
  secret_access_key: ENV['SES_SECRET'].to_s,
}

ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base, {
  access_key_id: Rails.application.secrets.ses_key.to_s,
  secret_access_key: Rails.application.secrets.ses_secret.to_s,
}

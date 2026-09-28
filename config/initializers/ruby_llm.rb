RubyLLM.configure do |config|
  config.gemini_api_key = ENV.fetch('GEMINI_API_KEY', nil)
end

RubyLLM.models.refresh! if Rails.env.production?

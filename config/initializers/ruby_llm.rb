RubyLLM.configure do |config|
  config.gemini_api_key = ENV.fetch('GEMINI_API_KEY', nil)
  config.use_new_acts_as = true
end

Rails.application.configure do

  config.generators do |g|
    g.haml true
    g.helper false
    g.stylesheets false
  end

end

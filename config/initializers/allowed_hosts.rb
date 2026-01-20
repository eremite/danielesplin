if Rails.env.development?
  Rails.application.configure do
    config.hosts << "penguin.linux.test"
  end
end

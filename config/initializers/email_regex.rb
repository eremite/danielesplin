Rails.application.configure do
  # https://gist.github.com/343843
  config.email_regex =
    /\A(?:[a-z\d!#\$%&'\*\+\-\/=\?\^_`\{\|\}~]+|\.)+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\Z/i
end

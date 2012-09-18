source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.8'

gem 'haml-rails'
gem 'jquery-rails'
gem 'paperclip'
gem 'sass'
gem 'sass-rails'

group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem 'pg'
  gem 'thin'
end

group :development, :test do
  gem 'guard'
  gem 'guard-test'
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'ruby-prof'
end

group :test do
  gem 'mocha'
end

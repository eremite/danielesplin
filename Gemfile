source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.8'

gem 'haml-rails'
gem 'jquery-rails'
gem 'sqlite3'
gem 'strong_parameters'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'sass-rails', '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
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
  gem 'sqlite3'
end

group :test do
  gem 'mocha'
end

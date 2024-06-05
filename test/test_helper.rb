ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_all_pending!

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def login(fixture_key)
  post "/sessions", params: { email: users(fixture_key).email, password: "secret" }
end

def login_as(user)
  user.tap { |u| @request.session['user_id'] = u.try(:id) }
end

def logout
  @request.session['user_id'] = nil
end

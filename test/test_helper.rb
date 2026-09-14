ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'

module ActiveSupport
  class TestCase

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def login(fixture_key)
      user = users(fixture_key)
      post '/sessions', params: { email: user.email, password: 'secret' }
      user
    end

    def logout
      @request.session['user_id'] = nil
    end

  end
end

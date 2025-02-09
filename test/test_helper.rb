ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def login(fixture_key)
      post "/sessions", params: { email: users(fixture_key).email, password: "secret" }
    end

    def login_as(user)
      user.tap { |u| @request.session['user_id'] = u.try(:id) }
    end

    def logout
      @request.session['user_id'] = nil
    end
  end
end

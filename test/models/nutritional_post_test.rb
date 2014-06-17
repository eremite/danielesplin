require 'test_helper'

class NutritionalPostTest < ActiveSupport::TestCase

  test 'valid' do
    assert nutritional_posts(:base).valid?
  end

end

require 'test_helper'

class BabyLogTest < ActiveSupport::TestCase

  test 'valid' do
    assert baby_logs(:base).valid?
  end

end

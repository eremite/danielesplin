require 'test_helper'

class ThoughtTest < ActiveSupport::TestCase

  test 'valid' do
    t = thoughts(:base)
    t.on = Date.today
    assert t.valid?
  end

end

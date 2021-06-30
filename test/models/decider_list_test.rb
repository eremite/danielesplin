require 'test_helper'

class DeciderListTest < ActiveSupport::TestCase

  test 'valid' do
    assert decider_lists(:base).valid?
  end

end

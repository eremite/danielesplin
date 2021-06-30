require 'test_helper'

class DeciderListItemTest < ActiveSupport::TestCase

  test 'valid' do
    assert decider_list_items(:base).valid?
  end

end

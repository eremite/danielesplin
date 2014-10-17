require 'test_helper'

class InventoryItemTest < ActiveSupport::TestCase

  test 'valid' do
    assert inventory_items(:base).valid?
  end

end

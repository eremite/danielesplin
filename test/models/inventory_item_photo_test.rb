require 'test_helper'

class InventoryItemPhotoTest < ActiveSupport::TestCase

  test 'valid' do
    assert inventory_item_photos(:base).valid?
  end

end

require 'test_helper'

class InventoryItemTest < ActiveSupport::TestCase

  test 'valid' do
    assert inventory_items(:base).valid?
  end

  test 'self.tags' do
    inventory_item = inventory_items(:base).tap { |e| e.update!(inventory_item_tag_list: 'first') }
    assert InventoryItem.tags.exists?(name: 'first')
  end

  test 'suggested_tags' do
    inventory_item = inventory_items(:base).tap { |e| e.update!(inventory_item_tag_list: 'existing') }
    second = InventoryItem.create!(name: 'C', inventory_item_tag_list: 'suggested')
    assert_not inventory_item.suggested_tags.exists?(name: 'existing')
    assert inventory_item.suggested_tags.exists?(name: 'suggested')
  end

end

require 'test_helper'

class InventoryItemSearchTest < ActiveSupport::TestCase
  test 'self.order_options' do
    assert_equal %i[on_desc on_asc], InventoryItemSearch.order_options.map(&:last)
  end

  test 'load ends_on' do
    assert_equal Date.new(2030, 1, 31), InventoryItemSearch.new(ends_on: '2030-01-31').load.ends_on
    assert_equal Date.current, InventoryItemSearch.new(ends_on: 'invalid').load.ends_on
  end

  test 'load items' do
    item = inventory_items(:base)
    item.update_columns(name: 'Cooler')
    assert_includes InventoryItemSearch.new.load.inventory_items, item
    assert_includes InventoryItemSearch.new(term: 'cool').load.inventory_items, item
    assert_empty InventoryItemSearch.new(term: 'This is missing').load.inventory_items
  end
end

require 'test_helper'

class DeciderListItemTest < ActiveSupport::TestCase
  test 'valid' do
    assert decider_list_items(:base).valid?
  end

  test 'icon' do
    assert DeciderListItem.new.icon.present?
  end

  test 'font' do
    assert DeciderListItem.new.font.present?
  end
end

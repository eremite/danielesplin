require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  test 'valid' do
    assert entries(:base).valid?
  end

  test 'after_create_redirect_url' do
    entry = entries(:base)
    entry.at = 1.month.ago
    assert_not_nil entry.after_create_redirect_url
  end

end

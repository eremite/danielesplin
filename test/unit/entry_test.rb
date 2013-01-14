require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  test 'valid' do
    assert entries(:base).valid?
  end

  test 'title' do
    e = entries(:base)
    e.body = "## hello\nMore content"
    assert_equal "hello", e.title
  end

end

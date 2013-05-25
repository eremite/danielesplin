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

  test 'dated_title' do
    e = entries(:base)
    e.at = '2013-10-31'.to_date
    e.body = "## Halloween\nit was fun"
    assert_equal '10/31/2013 Halloween', e.dated_title
  end

end

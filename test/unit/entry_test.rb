require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  test 'valid' do
    assert entries(:base).valid?
  end

  test 'title' do
    e = entries(:base)
    e.body = '## hello'
    assert_equal "#{I18n.l(e.at.to_date)} hello", e.title
  end

end

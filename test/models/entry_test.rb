require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  test 'valid' do
    assert entries(:base).valid?
  end

  test 'self.tags' do
    entry = entries(:base).tap { |e| e.update!(entry_tag_list: 'first') }
    assert Entry.tags.exists?(name: 'first')
  end

  test 'after_create_redirect_url' do
    entry = entries(:base)
    entry.at = 1.month.ago
    assert_not_nil entry.after_create_redirect_url
  end

  test 'suggested_tags' do
    entry = entries(:base).tap { |e| e.update!(entry_tag_list: 'existing') }
    second = Entry.create!(body: 'C', user: users(:base), entry_tag_list: 'suggested')
    assert_not entry.suggested_tags.exists?(name: 'existing')
    assert entry.suggested_tags.exists?(name: 'suggested')
  end

end

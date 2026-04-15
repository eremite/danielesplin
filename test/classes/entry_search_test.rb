require 'test_helper'

class EntrySearchTest < ActiveSupport::TestCase
  test 'load ends_on' do
    user = users(:base)
    assert_equal Date.new(2024, 4, 20), EntrySearch.new(current_user: user, ends_on: '2024-04-20').load.ends_on
    assert_equal Date.current, EntrySearch.new(current_user: user, ends_on: 'invalid').load.ends_on
    user.update_columns(born_at: 1.year.ago)
    assert_equal Date.current, EntrySearch.new(current_user: user, age: '1').load.ends_on.to_date
  end

  test 'load user' do
    user = users(:base)
    assert_equal user.id, EntrySearch.new(current_user: user).load.user_id
  end

  test 'load entries' do
    entry = entries(:base)
    assert_includes EntrySearch.new(current_user: entry.user).load.entries, entry
    assert_empty EntrySearch.new(current_user: entry.user, on_this_day: '1').load.entries
  end
end

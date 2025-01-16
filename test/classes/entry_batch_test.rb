require 'test_helper'

class EntryBatchTest < ActiveSupport::TestCase

  test 'load finds existing entry' do
    entry = entries(:base)
    entry.update_columns(at: Time.current, body: "Body")
    user = entry.user
    user.update_columns(role: :baby)
    batch = EntryBatch.new.load
    params = batch.entry_params_by_user_id[user.id]
    assert_equal "Body", params[:body]
    assert_equal entry.id, params[:id]
  end

  test 'save can create new entry' do
    user = users(:baby)
    user.entries.destroy_all
    assert EntryBatch.new(entry_params_by_user_id: { user.id => { body: "New Entry" } }).save
    assert user.entries.find_by(at: Time.current.all_day, body: "New Entry")
  end

  test 'save can update existing entry' do
    entry = entries(:base)
    entry.update_columns(at: Time.current, body: "Existing")
    user = entry.user
    user.update_columns(role: :baby)
    assert EntryBatch.new(entry_params_by_user_id: { user.id => { body: "Updated" } }).save
    assert user.entries.find_by(at: Time.current.all_day, body: "Updated")
  end

end

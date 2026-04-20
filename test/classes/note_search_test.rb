require 'test_helper'

class NoteSearchTest < ActiveSupport::TestCase
  test 'load' do
    note = notes(:base)
    note.update_columns(body: 'This is my Note')
    assert_includes NoteSearch.new(current_user: note.user).load.notes, note
    assert_includes NoteSearch.new(current_user: note.user, term: 'not').load.notes, note
    assert_not_includes NoteSearch.new(current_user: note.user, term: 'not a |').load.notes, note
  end
end

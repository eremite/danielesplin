require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  test 'valid' do
    assert notes(:base).valid?
  end

  test 'self.tags' do
    note = notes(:base).tap { |e| e.update!(note_tag_list: 'first') }
    assert Note.tags.exists?(name: 'first')
  end

  test 'suggested_tags' do
    note = notes(:base).tap { |e| e.update!(note_tag_list: 'existing') }
    second = Note.create!(body: 'C', user: users(:base), note_tag_list: 'suggested')
    assert_not note.suggested_tags.exists?(name: 'existing')
    assert note.suggested_tags.exists?(name: 'suggested')
  end

end

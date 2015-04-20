require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  test 'valid' do
    assert notes(:base).valid?
  end

end

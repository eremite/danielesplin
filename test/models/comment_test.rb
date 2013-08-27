require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'valid' do
    assert comments(:base).valid?
  end

end

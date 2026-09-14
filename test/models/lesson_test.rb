require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  test 'valid' do
    assert lessons(:base).valid?
  end

end

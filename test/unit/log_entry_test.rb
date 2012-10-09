require 'test_helper'

class LogEntryTest < ActiveSupport::TestCase

  test 'valid' do
    assert log_entries(:base).valid?
  end

end

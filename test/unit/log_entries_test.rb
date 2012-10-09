require 'test_helper'

class LogEntriesTest < ActiveSupport::TestCase

  test 'valid' do
    assert log_entries(:base).valid?
  end

end

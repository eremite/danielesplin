require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  test 'valid' do
    assert entries(:base).valid?
  end

end

require 'test_helper'

class SavedFileTest < ActiveSupport::TestCase

  test 'valid' do
    assert saved_files(:base).valid?
  end

end

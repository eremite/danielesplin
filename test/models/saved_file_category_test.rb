require 'test_helper'

class SavedFileCategoryTest < ActiveSupport::TestCase

  test 'valid' do
    assert saved_file_categories(:base).valid?
  end

end

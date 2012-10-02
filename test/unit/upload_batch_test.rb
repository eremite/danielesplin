require 'test_helper'

class UploadBatchTest < ActiveSupport::TestCase

  test 'exists' do
    assert_not_nil UploadBatch.new
  end

  test 'new' do
    ub = UploadBatch.new(description: 'Description')
    assert_equal 'Description', ub.description
  end

  test 'persisted?' do
    assert !UploadBatch.new.persisted?
  end

  test 'save!' do
    Photo.any_instance.stubs(create!: true)
    assert UploadBatch.new(description: 'Saved').save!
  end

end

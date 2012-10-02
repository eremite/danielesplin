require 'test_helper'

class UploadBatchesControllerTest < ActionController::TestCase

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    UploadBatch.any_instance.stubs(save!: false)
    post :create, upload_batch: {}
    assert_template :new
  end

  test 'create valid' do
    UploadBatch.any_instance.stubs(save!: true)
    post :create, upload_batch: {}
    assert_redirected_to photos_url
  end

end

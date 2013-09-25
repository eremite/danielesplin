require 'test_helper'

class UploadBatchesControllerTest < ActionController::TestCase

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    UploadBatch.any_instance.stubs(save!: false)
    post :create, upload_batch: valid_attributes
    assert_template :new
  end

  test 'create valid' do
    UploadBatch.any_instance.stubs(save!: true)
    post :create, upload_batch: valid_attributes
    assert_redirected_to new_upload_batch_url
  end


  private

  def valid_attributes
    {
      description: 'Description',
      images: [],
    }
  end

end

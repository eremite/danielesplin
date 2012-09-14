require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  test 'index' do
    get :index
    assert_template 'index'
  end

  test 'new' do
    get :new
    assert_template 'new'
  end

end

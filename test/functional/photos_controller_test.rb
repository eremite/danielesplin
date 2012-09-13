require 'test_helper'

class PhotosControllerTest < ActionController::TestCase

  test 'index' do                                                                
    get :index                                                                   
    assert_template 'index'                                                      
  end                                                                            

end

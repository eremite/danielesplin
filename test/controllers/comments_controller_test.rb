require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:base))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'new' do
    get :new
    assert_template :new
  end

  test 'create invalid' do
    Comment.stub_any_instance :save, false do
      post :create, comment: valid_attributes
    end
    assert_template :new
  end

  test 'create valid' do
    Comment.stub_any_instance :save, true do
      post :create, comment: valid_attributes
    end
    assert_redirected_to :posts
  end

  test 'edit' do
    get :edit, id: comments(:base).id
    assert_template :edit
  end

  test 'update invalid' do
    Comment.stub_any_instance :update_attributes, false do
      put :update, id: comments(:base).id, comment: valid_attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    Comment.stub_any_instance :update_attributes, true do
      put :update, id: comments(:base).id, comment: valid_attributes
    end
    assert_redirected_to :posts
  end

  test 'destroy' do
    delete :destroy, id: comments(:base).id
    assert_redirected_to :posts
  end


  private

  def valid_attributes
    {
      post_id: posts(:base).id,
      body: 'Body',
    }
  end

end

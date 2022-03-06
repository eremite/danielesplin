require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'create invalid' do
    Comment.stub_any_instance :save, false do
      post :create, params: { comment: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    Comment.stub_any_instance :save, true do
      post :create, params: { comment: valid_attributes }
    end
    assert_redirected_to :posts
  end

  test 'edit' do
    get :edit, params: { id: comments(:base).id }
    assert_response :success
  end

  test 'update invalid' do
    Comment.stub_any_instance :update, false do
      put :update, params:{ id: comments(:base).id, comment: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    Comment.stub_any_instance :update, true do
      put :update, params: {id: comments(:base).id, comment: valid_attributes}
    end
    assert_redirected_to :posts
  end

  test 'destroy' do
    delete :destroy, params: { id: comments(:base).id }
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

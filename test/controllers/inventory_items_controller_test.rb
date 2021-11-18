require 'test_helper'

class InventoryItemsControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @inventory_item = inventory_items(:base)
    login_as(user)
  end

  test 'index' do
    get :index
    assert_response :success
  end

  test 'new' do
    get :new
    assert_response :success
  end

  test 'create invalid' do
    InventoryItem.stub_any_instance :save, false do
      post :create, params: { inventory_item: valid_attributes }
    end
    assert_response :success
  end

  test 'create valid' do
    InventoryItem.stub_any_instance :save, true do
      post :create, params: { inventory_item: valid_attributes }
    end
    assert_redirected_to :inventory_items
  end

  test 'edit' do
    get :edit, params: { id: @inventory_item.id }
    assert_response :success
  end

  test 'update invalid' do
    InventoryItem.stub_any_instance :update, false do
      put :update, params: { id: @inventory_item.id, inventory_item: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    InventoryItem.stub_any_instance :update, true do
      put :update, params: { id: @inventory_item.id, inventory_item: valid_attributes }
    end
    assert_redirected_to :inventory_items
  end

  test 'destroy' do
    delete :destroy, params: { id: @inventory_item.id }
    assert_redirected_to :inventory_items
  end


  private

  def valid_attributes
    {
      at: Time.zone.today,
      name: 'Couch',
    }
  end

end

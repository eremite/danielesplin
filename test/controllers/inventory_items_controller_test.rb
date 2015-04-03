require 'test_helper'

class InventoryItemsControllerTest < ActionController::TestCase

  def setup
    user = users(:admin)
    @inventory_item = inventory_items(:base)
    login_as(user)
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
    InventoryItem.stub_any_instance :save, false do
      post :create, inventory_item: valid_attributes
    end
    assert_template :new
  end

  test 'create valid' do
    InventoryItem.stub_any_instance :save, true do
      post :create, inventory_item: valid_attributes
    end
    assert_redirected_to :inventory_items
  end

  test 'edit' do
    get :edit, id: @inventory_item.id
    assert_template :edit
  end

  test 'update invalid' do
    InventoryItem.stub_any_instance :update_attributes, false do
      put :update, id: @inventory_item.id, inventory_item: valid_attributes
    end
    assert_template :edit
  end

  test 'update valid' do
    InventoryItem.stub_any_instance :update_attributes, true do
      put :update, id: @inventory_item.id, inventory_item: valid_attributes
    end
    assert_redirected_to :inventory_items
  end

  test 'destroy' do
    delete :destroy, id: @inventory_item.id
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

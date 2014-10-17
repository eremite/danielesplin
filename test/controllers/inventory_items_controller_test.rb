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
    InventoryItem.any_instance.stubs(save: false)
    post :create, inventory_item: valid_attributes
    assert_template :new
  end

  test 'create valid' do
    InventoryItem.any_instance.stubs(save: true)
    post :create, inventory_item: valid_attributes
    assert_redirected_to new_entry_url
  end

  test 'show' do
    get :show, id: @inventory_item.id
    assert_template :show
  end

  test 'edit' do
    get :edit, id: @inventory_item.id
    assert_template :edit
  end

  test 'update invalid' do
    InventoryItem.any_instance.stubs(update_attributes: false)
    put :update, id: @inventory_item.id, inventory_item: valid_attributes
    assert_template :edit
  end

  test 'update valid' do
    InventoryItem.any_instance.stubs(update_attributes: true)
    put :update, id: @inventory_item.id, inventory_item: valid_attributes
    assert_redirected_to inventory_items_url
  end

  test 'destroy' do
    delete :destroy, id: @inventory_item.id
    assert_redirected_to inventory_items_url
  end


  private

  def valid_attributes
    {
      at: Time.zone.today,
      name: 'Couch',
    }
  end

end

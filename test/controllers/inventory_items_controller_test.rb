require 'test_helper'

class InventoryItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @inventory_item = inventory_items(:base)
    login(:admin)
  end

  test 'index' do
    get '/inventory_items'
    assert_response :success
  end

  test 'new' do
    get '/inventory_items/new'
    assert_response :success
  end

  test 'create invalid' do
    post '/inventory_items', params: { inventory_item: invalid_attributes }
    assert_response :success
  end

  test 'create valid' do
    post '/inventory_items', params: { inventory_item: valid_attributes }
    assert_redirected_to :inventory_items
  end

  test 'edit' do
    get "/inventory_items/#{@inventory_item.id}/edit"
    assert_response :success
  end

  test 'update invalid' do
    put "/inventory_items/#{@inventory_item.id}", params: { inventory_item: invalid_attributes }
    assert_response :success
  end

  test 'update valid' do
    put "/inventory_items/#{@inventory_item.id}", params: { inventory_item: valid_attributes }
    assert_redirected_to :inventory_items
  end

  test 'destroy' do
    delete "/inventory_items/#{@inventory_item.id}"
    assert_redirected_to :inventory_items
  end


  private

  def valid_attributes
    {
      at: Time.zone.today,
      name: 'Couch',
    }
  end

  def invalid_attributes
    {
      at: Time.zone.today,
      name: '',
    }
  end

end

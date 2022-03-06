require 'test_helper'

class DeciderListItemsControllerTest < ActionDispatch::IntegrationTest

  setup do
    login(:admin)
    @list = decider_lists(:base)
  end

  test 'create invalid' do
    post "/decider_lists/#{@list.id}/decider_list_items",
      params: { decider_list_item: { name: '', decider_list_id: @list.id } }
    assert_redirected_to @list
  end

  test 'create valid' do
    post "/decider_lists/#{@list.id}/decider_list_items",
      params: { decider_list_item: { name: 'Name', decider_list_id: @list.id } }
    assert_redirected_to @list
  end

  test 'destrpy' do
    delete "/decider_list_items/#{decider_list_items(:base).id}"
    assert_redirected_to @list
  end

end

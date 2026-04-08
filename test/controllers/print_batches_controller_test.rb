require 'test_helper'

class PrintBatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login(:admin)
  end

  test 'index' do
    get '/print_batches'
    assert_response :success
  end

  test 'entries' do
    get '/print_batches/entries', params: { user_id: users(:admin).id, year: Time.zone.now.year }
    assert_response :success
  end

  test 'posts' do
    get '/print_batches/posts', params: { year: Time.zone.now.year }
    assert_response :success
  end
end

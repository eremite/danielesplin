require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    user = users(:admin)
    @entry = user.entries.create!(body: 'body', at: Time.zone.now)
    login(:admin)
  end

  test 'index' do
    get '/entries'
    assert_response :success
  end

  test 'create valid' do
    post '/entries', params: { entry: valid_attributes }
    assert_redirected_to "/entries/#{Entry.last.id}/edit"
  end

  test 'edit' do
    get "/entries/#{@entry.id}/edit"
    assert_response :success
  end

  test 'update invalid' do
    Entry.stub_any_instance :update, false do
      put "/entries/#{@entry.id}", params: { entry: valid_attributes }
    end
    assert_response :success
  end

  test 'update valid' do
    Entry.stub_any_instance :update, true do
      Entry.stub_any_instance :after_create_redirect_url, [:entries] do
        put "/entries/#{@entry.id}", params: { entry: valid_attributes }
      end
    end
    assert_redirected_to entries_path
  end

  test 'destroy' do
    delete "/entries/#{@entry.id}"
    assert_redirected_to "/entries"
  end


  private

  def valid_attributes
    {
      at: Time.zone.now,
      body: 'Body',
    }
  end

end

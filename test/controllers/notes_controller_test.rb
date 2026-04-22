require 'test_helper'

class NotesControllerTest < ActionDispatch::IntegrationTest

  setup do
    user = users(:admin)
    @note = user.notes.create!(title: 'Title', body: 'body')
    login(:admin)
  end

  test 'index' do
    get '/notes'
    assert_response :success
  end

  test 'new' do
    get '/notes/new'
    assert_response :success
  end

  test 'create valid' do
    post '/notes', params: { note: @note.attributes }
    assert_redirected_to "/notes/#{Note.last.id}/edit"
  end

  test 'show' do
    get "/notes/#{@note.id}"
    assert_response :success
  end

  test 'edit' do
    get "/notes/#{@note.id}/edit"
    assert_response :success
  end

  test 'update valid' do
    put "/notes/#{@note.id}", params: { note: @note.attributes }
    assert_redirected_to "/notes/#{Note.last.id}/edit"
  end

  test 'destroy' do
    delete "/notes/#{@note.id}"
    assert_redirected_to '/notes'
  end

end

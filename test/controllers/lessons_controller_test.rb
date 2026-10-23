require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest

  setup do
    login(:admin)
  end

  test 'index' do
    get '/lessons'
    assert_response :success
  end

  test 'create' do
    post '/lessons', params: { lesson: { question: 'How?' } }
    assert_redirected_to :lessons
  end

  test 'edit' do
    get "/lessons/#{lessons(:base).id}/edit"
    assert_response :success
  end

  test 'update invalid' do
    Lesson.stub_any_instance :update, false do
      put "/lessons/#{lessons(:base).id}", params: { lesson: { question: 'Why?' } }
    end
    assert_response :success
  end

  test 'update valid' do
    put "/lessons/#{lessons(:base).id}", params: { lesson: { question: 'Why?' } }
    assert_redirected_to :lessons
  end

  test 'destroy' do
    delete "/lessons/#{lessons(:base).id}"
    assert_redirected_to :lessons
  end

end

require 'test_helper'

class MealPlansControllerTest < ActionDispatch::IntegrationTest

  setup do
    login(:admin)
  end

  test 'create' do
    post '/meal_plans'
    assert_redirected_to :lessons
  end

end

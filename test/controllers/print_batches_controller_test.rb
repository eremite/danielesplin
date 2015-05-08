require 'test_helper'

class PrintBatchesControllerTest < ActionController::TestCase

  def setup
    login_as(users(:admin))
  end

  test 'index' do
    get :index
    assert_template :index
  end

  test 'print' do
    get :print, :user_id => users(:admin).id, year: Time.zone.now.year
    assert_template :print
  end

end

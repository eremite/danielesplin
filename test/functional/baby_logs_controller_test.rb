require 'test_helper'

class BabyLogsControllerTest < ActionController::TestCase

  def setup
    @baby_log = users(:baby).baby_logs.create!(kind: 'feeding')
    login_as(users(:admin))
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
    BabyLog.any_instance.stubs(save: false)
    post :create, baby_log: {}
    assert_template :new
  end

  test 'create valid' do
    BabyLog.any_instance.stubs(save: true)
    post :create, baby_log: {}
    assert_redirected_to baby_logs_url
  end

  # test 'edit' do
  #   get :edit, id: @baby_log.id
  #   assert_template :edit
  # end

  # test 'update invalid' do
  #   BabyLog.any_instance.stubs(valid?: false)
  #   put :update, id: @baby_log.id, baby_log: {}
  #   assert_template :edit
  # end

  # test 'update valid' do
  #   BabyLog.any_instance.stubs(valid?: true)
  #   put :update, id: @baby_log.id, baby_log: {}
  #   assert_redirected_to entries_url
  # end

  # test 'destroy' do
  #   delete :destroy, id: @baby_log.id
  #   assert_redirected_to entries_url
  # end

end

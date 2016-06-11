require 'test_helper'

class ConfigNerdsControllerTest < ActionController::TestCase
  setup do
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  test "should create a config_nerd model if none exists, done in application_controller" do
    ConfigNerd.first.destroy
    @admin = users(:admin)
    sign_in @admin

    get :edit
    assert_response :success
    assert_not_nil assigns(:config_nerd)
  end

  test "should get edit, with Admin user" do
    @admin = users(:admin)
    sign_in @admin

    get :edit
    assert_response :success
  end
  
  test "should NOT get edit, without Admin user" do
    @user = users(:subscribed)
    sign_in @user

    get :edit
    assert_redirected_to root_path
  end
  
  test "should update config_nerd" do
    sign_in users(:admin)
    config_nerd_id = ConfigNerd.first.id
    patch :update, id: config_nerd_id , config_nerd: { video_ad_id: "balloons" }
    @config_nerd = ConfigNerd.find_by_id(config_nerd_id)
    assert_equal("balloons", @config_nerd.video_ad_id)
    assert_redirected_to edit_config_nerd_path
  end

  test "should NOT update config_nerd due to invalid parameter" do
    sign_in users(:admin)
    config_nerd_id = ConfigNerd.first.id
    patch :update, id: config_nerd_id , config_nerd: { video_ad_id: "" }
    @config_nerd = ConfigNerd.find_by_id(config_nerd_id)
    assert_equal("ad_id", @config_nerd.video_ad_id)
    assert_template :edit
  end

  test "should Not update config_nerd if Not Admin" do
    sign_in users(:subscribed)
    config_nerd_id = ConfigNerd.first.id
    patch :update, id: config_nerd_id , config_nerd: { video_ad_id: "balloons" }
    @config_nerd = ConfigNerd.find_by_id(config_nerd_id)
    assert_not_equal("balloons", @config_nerd.video_ad_id)
    assert_redirected_to root_path
  end

  test "should Not update config_nerd if Not Signed In, redirect to sign in page" do
    config_nerd_id = ConfigNerd.first.id
    patch :update, id: config_nerd_id, config_nerd: {video_ad_id: "balloons" }
    assert_redirected_to new_user_session_path
  end
end

require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
  end

  test "should get index, no user" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get index, user not liked" do
    @user = users(:subscribed)
    sign_in @user

    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end
  
  test "should get index, visitor has liked" do
    @config_nerd = ConfigNerd.first 
    @jar = ActionDispatch::Cookies::CookieJar.build(@request)
    @jar.signed[:voting_id] = "1234"
    @request.cookies[:voting_id] = @jar[:voting_id]
    voter = voters(:one)
    voter.voting_id = "1234"
    voter.save
    voter.likes @config_nerd

    get :index
    assert_response :success
  end

  test "should get index, with video_stream_id" do
    cn = config_nerds(:one)
    cn.live = true
    cn.video_stream_id = "live"
    cn.video_temp_id = "temp"
    cn.video_ad_id = "ad"
    cn.save

    get :index
    assert_response :success
    assert_equal "live", assigns(:video_home_id)
  end

  test "should get index, with video_temp_id" do
    cn = config_nerds(:one)
    cn.live = false
    cn.video_stream_id = "live"
    cn.video_temp_id = "temp"
    cn.video_ad_id = "ad"
    cn.save

    get :index
    assert_response :success
    assert_equal "temp", assigns(:video_home_id)
  end

  test "should get index, with video_ad_id" do
    cn = config_nerds(:one)
    cn.live = false
    cn.video_stream_id = "live"
    cn.video_temp_id = ""
    cn.video_ad_id = "ad"
    cn.save

    get :index
    assert_response :success
    assert_equal "ad", assigns(:video_home_id)
  end

  test "should get index, with video_ad_id if video_stream_id missing" do
    # Even if live is set to true, if video_stream_id is not present then live flag gets ignored.
    cn = config_nerds(:one)
    cn.live = true
    cn.video_stream_id = ""
    cn.video_temp_id = ""
    cn.video_ad_id = "ad"
    cn.save

    get :index
    assert_response :success
    assert_equal "ad", assigns(:video_home_id)
  end

end

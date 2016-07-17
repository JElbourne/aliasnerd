require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  setup do
    @video = videos(:one)
    @request.env['HTTP_REFERER'] = 'http://test.host/videos'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get index with a project's id" do
    get :index, project: projects(:one).id
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get show if subscribed" do
    sign_in users(:subscribed)
    get :show, id: @video
    assert_response :success
  end

  test "should NOT get show if not subscribed, not logged in" do
    get :show, id: @video
    assert_redirected_to new_subscription_path
  end

  test "should NOT get show if not subscribed, is logged in." do
    sign_in users(:unsubscribed)
    get :show, id: @video
    assert_redirected_to new_subscription_path
  end

  test "should get new if Admin" do
    sign_in users(:admin)
    get :new
    assert_response :success
  end

  test "should Not get new if Not Admin" do
    get :index
    sign_in users(:subscribed)
    get :new
    assert_redirected_to videos_path
  end

  test "should Not get new if Not logged in, redirect to login page" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should create video if Admin User" do
    sign_in users(:admin)
    assert_difference('Video.count') do
      post :create, video: { description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    end
    assert_redirected_to videos_path
  end

  test "should not create video if not Admin" do
    sign_in users(:subscribed)
    assert_no_difference('Video.count') do
      post :create, video: { description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    end
    assert_redirected_to videos_path
  end

  test "should Not create video if not valid, renders :new action" do
    sign_in users(:admin)
    assert_no_difference('Video.count') do
      ## Missing Description, should fail
      post :create, video: { name: @video.name, video_source_id: @video.video_source_id }
    end
    assert_template :new
  end

  test "should get edit if Admin" do
    sign_in users(:admin)
    get :edit, id: @video
    assert_response :success
  end

  test "should Not get edit if Not Admin" do
    sign_in users(:subscribed)
    get :edit, id: @video
    assert_redirected_to videos_path
  end

  test "should not get edit, if not signed in" do
    get :edit, id: @video
    assert_redirected_to new_user_session_path
  end

  test "should update video if Admin" do
    sign_in users(:admin)
    video_id = @video.id
    patch :update, id: @video, video: { description: "balloons" }
    @video = Video.find_by_id(video_id)
    assert_equal("balloons", @video.description)
    assert_redirected_to videos_path
  end
  
  test "should Not update video if Not Admin" do
    sign_in users(:subscribed)
    video_id = @video.id
    patch :update, id: @video, video: { description: "balloons" }
    @video = Video.find_by_id(video_id)
    assert_not_equal("balloons", @video.description)
    assert_redirected_to videos_path
  end
 
  test "should not update video, if not signed in" do
    patch :update, id: @video, video: {  description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    assert_redirected_to new_user_session_path
  end

  test "should Not update video if not valid, renders :edit action" do
    sign_in users(:admin)
    ## Invalid Name will not allow update
    patch :update, id: @video, video: {name: "1"}
    assert_template :edit
  end

  test "should destroy video if Admin" do
    sign_in users(:admin)
    assert_difference('Video.count', -1) do
      delete :destroy, id: @video
    end
    assert_redirected_to videos_path
  end
  
  test "should Not destroy video if Not Admin" do
    sign_in users(:subscribed)
    assert_no_difference('Video.count') do
      delete :destroy, id: @video
    end
    assert_redirected_to videos_path
  end
  
  test "should not destroy video if not signed in" do
    delete :destroy, id: @video
    assert_redirected_to new_user_session_path
  end
end

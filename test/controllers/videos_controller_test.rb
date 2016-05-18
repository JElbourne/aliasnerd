require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  setup do
    @user = users(:subscribed)
    @video = videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:videos)
  end

  test "should get show" do
    get :show, id: @video
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get :new
    assert_response :success
  end
  
  test "should not get new if not signed in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should create video" do
    sign_in @user
    assert_difference('Video.count') do
      post :create, video: { description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    end

    assert_redirected_to videos_path
  end

  test "should not create video if not signed in" do
    post :create, video: { description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't create video if not valid, renders :new action" do
    sign_in @user
    assert_no_difference('Video.count') do
      ## Missing Description, should fail
      post :create, video: { name: @video.name, video_source_id: @video.video_source_id }
    end
    assert_template :new
  end

  test "should get edit" do
    sign_in @user
    get :edit, id: @video
    assert_response :success
  end

  test "should not get edit, if not signed in" do
    get :edit, id: @video
    assert_redirected_to new_user_session_path
  end

  test "should update video" do
    sign_in @user
    patch :update, id: @video, video: { description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    assert_redirected_to videos_path
  end

  test "should not update video, if not signed in" do
    patch :update, id: @video, video: {  description: @video.description, name: @video.name, video_source_id: @video.video_source_id }
    assert_redirected_to new_user_session_path
  end

  test "shouldn't update video if not valid, renders :edit action" do
    sign_in @user
    ## Invalid Name will not allow update
    patch :update, id: @video, video: {name: "?$@@$#"}
    assert_template :edit
  end

  test "should destroy video" do
    sign_in @user
    assert_difference('Video.count', -1) do
      delete :destroy, id: @video
    end
    assert_redirected_to videos_path
  end
  
  test "should not destroy video if not signed in" do
    delete :destroy, id: @video
    assert_redirected_to new_user_session_path
  end
end

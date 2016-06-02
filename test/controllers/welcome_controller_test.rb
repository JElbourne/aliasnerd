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
end

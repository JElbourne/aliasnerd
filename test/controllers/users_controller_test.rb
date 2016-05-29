require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:subscribed)
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  test "should update liked attribute" do
    sign_in @user
    patch :liked
    assert_redirected_to root_path
  end
  
  test "should redirectl from update liked if user not signed in" do
    patch :liked
    assert_redirected_to new_user_session_path
  end
end

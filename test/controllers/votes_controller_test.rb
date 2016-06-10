require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @jar = ActionDispatch::Cookies::CookieJar.build(@request)
    @jar.signed[:voting_id] = "1234"
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  test "should update liked attribute" do
    post :vote_up
    assert_redirected_to root_path
  end
  
  test "should update liked attribute with cookie" do
    @request.cookies[:voting_id] = @jar[:voting_id]
    post :vote_up
    assert_redirected_to root_path
  end
end

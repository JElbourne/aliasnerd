require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @request.env['HTTP_REFERER'] = 'http://test.host/'
  end

  test "should update liked attribute" do
    post :vote_up
    assert_redirected_to root_path
  end
end

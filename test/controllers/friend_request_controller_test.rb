require 'test_helper'

class FriendRequestControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get friend_request_new_url
    assert_response :success
  end

  test "should get create" do
    get friend_request_create_url
    assert_response :success
  end

  test "should get destroy" do
    get friend_request_destroy_url
    assert_response :success
  end

end

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get mypage" do
    get user_mypage_url
    assert_response :success
  end

  test "should get complete" do
    get user_complete_url
    assert_response :success
  end

end

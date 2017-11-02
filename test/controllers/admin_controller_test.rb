require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get title" do
    get admin_title_url
    assert_response :success
  end

  test "should get content" do
    get admin_content_url
    assert_response :success
  end

  test "should get img" do
    get admin_img_url
    assert_response :success
  end

  test "should get username" do
    get admin_username_url
    assert_response :success
  end

end

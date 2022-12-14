require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should not get index without being logged in" do
    get root_path
    assert_response :redirect
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_select "input#session_email"
  end

  test "should get index" do
    sign_up
    
    get root_path
    assert_select "h1", "Home"
    assert_response :success
  end
end

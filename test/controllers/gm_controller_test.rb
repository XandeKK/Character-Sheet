require "test_helper"

class GmControllerTest < ActionDispatch::IntegrationTest
  test "should not get index without being logged in" do
    get gm_path
    assert_response :redirect
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_select "input#session_email"
  end

  test "should get index" do
    sign_up
    
    get gm_path
    assert_select "h1", "Gm"
    assert_response :success
  end
end

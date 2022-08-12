require "test_helper"

class GmControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_up

    get gm_path
    assert_select "h1", "Gm"
    assert_response :success
  end

  test "should not get index" do
    get gm_path
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
    follow_redirect!
    assert_select "input#session_email"
  end
end

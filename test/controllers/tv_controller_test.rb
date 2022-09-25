require "test_helper"

class TvControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_up

    get tv_path
    assert_select "#server-name"
    assert_response :success
  end

  test "should not get show" do
    get tv_path
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
    follow_redirect!
    assert_select "input#session_email"
  end
end

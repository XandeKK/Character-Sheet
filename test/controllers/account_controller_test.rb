require "test_helper"

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_up
    get account_path
    assert_select "h1", "Account"
    assert_response :success
  end

  test "should not get show without sign up in session" do
    get account_path
    assert_response :redirect
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_select "input#session_email"
  end
end

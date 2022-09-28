require "test_helper"

class PlayerControllerTest < ActionDispatch::IntegrationTest
  test "should not get index without being logged in" do
    get player_path
    assert_response :redirect
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_select "input#session_email"
  end

  test "should get index" do
    sign_up
    
    get player_path
    assert_select "h1", "Characters"
    assert_select "#character-#{pathfinder_basics(:one).name}"
    assert_response :success
  end
end

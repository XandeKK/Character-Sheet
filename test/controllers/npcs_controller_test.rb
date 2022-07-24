require "test_helper"

class NpcsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_up

    get npcs_path
    assert_response :success
  end

  test "should not get index" do
    get npcs_path
    assert_response :redirect

    assert_equal "Please sign in to continue.", flash[:alert]
  end
end

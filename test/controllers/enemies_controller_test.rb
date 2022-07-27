require "test_helper"

class EnemiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_up

    get enemies_path
    assert_response :success
  end

  test "should not get index" do
    get enemies_path
    assert_response :redirect

    assert_equal "Please sign in to continue.", flash[:alert]
  end
end
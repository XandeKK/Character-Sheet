require "test_helper"

class CampaignPlayerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_up

    get campaigns_player_path
    assert_response :success
  end

  test "should not get index" do
    get campaigns_player_path
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
  end

  test "should get show" do
    sign_up

    get campaign_player_path(adventures(:one))
    assert_response :success
  end

  test "should not get show" do
    get campaign_player_path(adventures(:one))
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
  end
end

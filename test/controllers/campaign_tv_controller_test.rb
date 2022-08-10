require "test_helper"

class CampaignTvControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_up

    get campaign_tv_path(adventures(:one))
    assert_response :success
  end

  test "should not get show" do
    get campaign_tv_path(adventures(:one))
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
  end

  test "should sign up in campaign" do
    sign_up

    post sign_up_campaign_tv_path(format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: 123
    }
    assert_response :ok
  end

  test "should not sign up in campaign" do
    sign_up

    post sign_up_campaign_tv_path(format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: ''
    }
    assert_response :unprocessable_entity
  end

  test "should not sign up in campaign without sign up in session" do
    post sign_up_campaign_tv_path(format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: ''
    }
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
  end
end

require "test_helper"

class CampaignTvControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    sign_up

    get campaign_tv_path(adventures(:one))
    assert_response :success
    assert_select "div#chat"
  end

  test "should not get show" do
    get campaign_tv_path(adventures(:one))
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
    follow_redirect!
    assert_select "input#session_email"
  end

  test "should sign up in campaign" do
    sign_up

    post sign_up_campaign_tv_path(format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: 123
    }
    assert_response :ok
    assert_select 'turbo-stream[action="remove"]'
  end

  test "should not sign up in campaign" do
    sign_up

    post sign_up_campaign_tv_path(format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: ''
    }
    assert_response :unprocessable_entity
    assert_select 'turbo-stream[action="replace"]'
  end

  test "should not sign up in campaign without sign up in session" do
    post sign_up_campaign_tv_path(format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: ''
    }
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
    follow_redirect!
    assert_select "input#session_email"
  end
end

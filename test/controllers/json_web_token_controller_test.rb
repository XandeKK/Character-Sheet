require "test_helper"

class JsonWebTokenControllerTest < ActionDispatch::IntegrationTest
  test "create a token" do
    sign_up
    post create_token_path(format: :turbo_stream)
    assert_response :ok
    assert_select "turbo-stream[action=replace]"
  end
end

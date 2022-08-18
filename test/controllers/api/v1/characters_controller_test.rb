require "test_helper"

class Api::V1::CharactersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @character = characters(:one)
    user = users(:one)
    @token = JsonWebToken.encode(user_id: user.id)
  end

  test "should get user not found" do
    @token = JsonWebToken.encode(user_id: -12)
    get api_v1_characters_path, headers: {"Authorization": @token}
    response_body = JSON.parse(response.body)
    assert_equal response_body["errors"], "Couldn't find User with 'id'=#{-12}"
  end

  test "get all characters" do
    get api_v1_characters_path, headers: {"Authorization": @token}
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal response_body["names"][0], @character.slug
  end

  test "don't get all characters without token" do
    get api_v1_characters_path
    assert_response :unauthorized
    response_body = JSON.parse(response.body)
    assert_equal response_body["errors"], "Nil JSON web token"
  end

  test "get info character" do
    get api_v1_character_path(@character), headers: {"Authorization": @token}
    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal response_body, JSON.parse(@character.statistic)
  end

  test "don't get info character without character id or name" do
    get api_v1_character_path('user'), headers: {"Authorization": @token}
    assert_response :unprocessable_entity
    response_body = JSON.parse(response.body)
    assert_equal response_body["errors"], "can't find record with friendly id: \"user\""
  end

  test "don't get info character without token" do
    get api_v1_character_path(@character)
    assert_response :unauthorized
    response_body = JSON.parse(response.body)
    assert_equal response_body["errors"], "Nil JSON web token"
  end
end

require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest

  def character
    characters(:one)
  end

  def user
    users(:one)
  end

  test "should get index" do
    sign_up
    
    get characters_path
    assert_select "h1", "Characters"
    assert_response :success
  end

  test "should get show" do
    sign_up
    
    get character_path(character)
    assert_select "h1#characterName", "undefined"
    assert_response :success
  end

  test "should not get show character which does not belong to the user" do
    sign_up_with_other_user
    
    get characters_path(character)
    assert_select "h1", "Characters"
    assert_response :success
  end

  test "should create character" do
    sign_up

    assert_difference("Character.count") do
      post characters_path, params: { category: "Player"}
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1#characterName", "undefined"
    assert_equal "Character created successfully", flash[:notice]
  end

  test "should update character" do
    sign_up
    character_json = File.read("#{Rails.root}/test/fixtures/files/character_test.json")

    put character_path(character), params: {
      character: {
        name: "Tolo",
        statistic: character_json,
      character_image: "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1#characterName", "Fool"
    assert_equal "Character successfully updated", flash[:notice]
  end

  test "should not update character which does not belong to the user" do
    sign_up_with_other_user

    put character_path(character), params: {
      character: {
        name: "Tolo",
        statistic: '{"You": "Fool"}',
      character_image: "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Characters"
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should destroy character" do
    sign_up

    assert_difference("Character.count", -1) do
      delete character_path(character)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Characters"
    assert_equal "Character successfully deleted", flash[:notice]
  end

  test "should not destroy character which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("Character.count") do
      delete character_path(character)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Characters"
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should update one character life" do
    sign_up

    get character_path(character)

    put character_update_all_life_path(character), params: {
      characters: "{\"#{characters(:one).id}\":{\"maxHp\":\"0\",\"currentHp\":0,\"temporary\":15}}"
    }

    assert_response :ok
    assert_equal @response.body, "OK"
  end

  test "should update multiple characters life" do
    sign_up

    put character_update_all_life_path(character), params: {
      characters: "{\"#{characters(:one).id}\":{\"maxHp\":\"0\",\"currentHp\":0,\"temporary\":14},\"#{characters(:two).id}\":{\"maxHp\":\"0\",\"currentHp\":0,\"temporary\":14}}"
    }

    assert_response :ok
    assert_equal @response.body, "OK"
  end

  test "should sign up in server" do
    sign_up

    post sign_up_character_path(characters(:one), format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: 123
    }
    assert_response :ok
    assert_select 'turbo-stream[action="remove"]'
  end

  test "should not sign up in server" do
    sign_up

    post sign_up_character_path(characters(:one), format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: ''
    }
    assert_response :unprocessable_entity
    assert_select "div.alert-warning", "Server name or password is wrong."
  end

  test "should not sign up in server without sign up in session" do
    post sign_up_character_path(characters(:one), format: :turbo_stream), params: {
      unique_name: adventures(:one).unique_name,
      password: ''
    }
    assert_response :redirect
    assert_equal "Please sign in to continue.", flash[:alert]
    follow_redirect!
    assert_select "input#session_email"
  end
end

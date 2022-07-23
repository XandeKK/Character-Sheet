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
    assert_response :success
  end

  test "should get show" do
    sign_up
    
    get characters_path(character)
    assert_response :success
  end

  test "should not get show character which does not belong to the user" do
    sign_up_with_other_user
    
    get characters_path(character)
    assert_response :success
  end

  test "should get new" do # Planejo remover
    sign_up

    get new_character_path
    assert_response :success
  end

  test "should get edit" do # Planejo remover
    sign_up

    get edit_character_path(character)
    assert_response :success
  end

  test "should not get edit character which does not belong to the user" do # Planejo remover
    sign_up_with_other_user

    get edit_character_path(character)
    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should create character" do
    sign_up

    assert_difference("Character.count") do
      post characters_path, params: {
        character: {
          name: "Pikachu",
          statistic: {}
        }
      }
    end

    assert_response :redirect
    assert_equal "Character created successfully", flash[:notice]
  end

  test "should not create character without name" do
    sign_up

    assert_no_difference("Character.count") do
      post characters_path, params: {
        character: {
          name: nil,
          statistic: {}
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should update character" do
    sign_up

    put character_path(character), params: {
      character: {
        name: "Tolo",
        statistic: {"You": "Fool"}
      }
    }

    assert_response :redirect
    assert_equal "Character successfully updated", flash[:notice]
  end

  test "should not update character without name" do
    sign_up

    put character_path(character), params: {
      character: {
        name: nil,
        statistic: {"You": "Fool"}
      }
    }

    assert_response :unprocessable_entity
  end

  test "should not update character which does not belong to the user" do
    sign_up_with_other_user

    put character_path(character), params: {
      character: {
        name: "Tolo",
        statistic: {"You": "Fool"}
      }
    }

    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should destroy character" do
    sign_up

    assert_difference("Character.count", -1) do
      delete character_path(character)
    end

    assert_response :redirect
    assert_equal "Character successfully deleted", flash[:notice]
  end

  test "should not destroy character which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("Character.count") do
      delete character_path(character)
    end

    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end
end

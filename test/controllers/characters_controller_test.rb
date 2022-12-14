require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = character_categories(:one).name
    @category_pluralize = @category.pluralize
  end

  def character
    characters(:one)
  end

  def user
    users(:one)
  end

  test "should get show" do
    sign_up
    
    get character_path(category: @category, id: character)
    assert_select "h1", character.pathfinder_basic.name
    assert_response :success
  end

  test "should not get show character which does not belong to the user" do
    sign_up_with_other_user
    
    get character_path(category: @category, id: character)
    follow_redirect!
    assert_select "h1", @category_pluralize
    assert_response :success
  end

  test "should get new" do
    sign_up

    get new_character_path(category: @category)
    assert_select "h2", "New Character"
    assert_response :success
  end

  test "should create character" do
    sign_up

    assert_difference("Pathfinder::Basic.count") do
      assert_difference("Character.count") do
        post characters_path(category: @category), params: {
          system: character_systems(:one).id
        }
      end
    end

    assert_response :redirect
    follow_redirect!
    assert_equal "#{@category} created successfully!", flash[:notice]
  end

  test "should update character" do
    sign_up

    put character_path(category: @category, id: character), params: {
      character: {
        pathfinder_basic_attributes: {"name": "Tolo"},
        image: ""
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "#character-name", "Tolo"
    assert_equal "#{@category} successfully updated!", flash[:notice]
  end

  test "should not update character which does not belong to the user" do
    sign_up_with_other_user

    put character_path(category: @category, id: character), params: {
      character: {
        name: "Tolo"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1", @category_pluralize
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should destroy character" do
    sign_up

    assert_difference("Character.count", -1) do
      delete character_path(category: @category, id: character)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", @category_pluralize
    assert_equal "#{@category} successfully deleted!", flash[:notice]
  end

  test "should not destroy character which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("Character.count") do
      delete character_path(category: @category, id: character)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", @category_pluralize
    assert_equal "You do not have permission.", flash[:alert]
  end
end

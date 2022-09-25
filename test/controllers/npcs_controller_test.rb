require "test_helper"

class NpcsControllerTest < ActionDispatch::IntegrationTest
  def npc
    characters(:two)
  end

  def user
    users(:two)
  end

  test "should not get index without being logged in" do
    get npcs_path
    assert_response :redirect
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_select "input#session_email"
  end

  test "should get index" do
    sign_up_with_other_user
    
    get npcs_path
    assert_select "h1", "Npcs"
    assert_select "#npc-#{pathfinder_basics(:two).name}"
    assert_response :success
  end

  test "should get show" do
    sign_up_with_other_user
    
    get npc_path(npc)
    assert_select "h1", npc.pathfinder_basic.name
    assert_response :success
  end

  test "should not get show character which does not belong to the user" do
    sign_up
    
    get npc_path(npc)
    follow_redirect!
    assert_select "h1", "Npcs"
    assert_response :success
  end

  test "should get new" do
    sign_up_with_other_user

    get new_npc_path
    assert_select "h2", "New Npc"
    assert_response :success
  end

  test "should create npc" do
    sign_up_with_other_user

    assert_difference("Pathfinder::Basic.count") do
      assert_difference("Character.count") do
        post npcs_path, params: { system: character_systems(:one).id }
      end
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Nameless"
    assert_equal "Npc created successfully!", flash[:notice]
  end

  test "should update npc" do
    sign_up_with_other_user

    put npc_path(npc), params: {
      character: {
        pathfinder_basic_attributes: {"name": "Tolo"}
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Tolo"
    assert_equal "Npc successfully updated!", flash[:notice]
  end

  test "should not update character which does not belong to the user" do
    sign_up

    put npc_path(npc), params: {
      character: {
        name: "Tolo"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Npcs"
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should destroy npc" do
    sign_up_with_other_user

    assert_difference("Character.count", -1) do
      delete npc_path(npc)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Npcs"
    assert_equal "Npc successfully deleted!", flash[:notice]
  end

  test "should not destroy character which does not belong to the user" do
    sign_up

    assert_no_difference("Character.count") do
      delete npc_path(npc)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Npcs"
    assert_equal "You do not have permission.", flash[:alert]
  end
end

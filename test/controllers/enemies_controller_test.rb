require "test_helper"

class EnemiesControllerTest < ActionDispatch::IntegrationTest
  def enemy
    characters(:three)
  end

  def user
    users(:two)
  end

  test "should not get index without being logged in" do
    get enemies_path
    assert_response :redirect
    assert_redirected_to sign_in_path
    follow_redirect!
    assert_select "input#session_email"
  end

  test "should get index" do
    sign_up_with_other_user
    
    get enemies_path
    assert_select "h1", "Enemies"
    assert_select "#enemy-#{pathfinder_basics(:three).name}"
    assert_response :success
  end

  test "should get show" do
    sign_up_with_other_user
    
    get enemy_path(enemy)
    assert_select "h1", enemy.pathfinder_basic.name
    assert_response :success
  end

  test "should not get show character which does not belong to the user" do
    sign_up
    
    get enemy_path(enemy)
    follow_redirect!
    assert_select "h1", "Enemies"
    assert_response :success
  end

  test "should get new" do
    sign_up_with_other_user

    get new_enemy_path
    assert_select "h2", "New Enemy"
    assert_response :success
  end

  test "should create enemy" do
    sign_up_with_other_user

    assert_difference("Pathfinder::Basic.count") do
      assert_difference("Character.count") do
        post enemies_path, params: { system: character_systems(:one).id }
      end
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Nameless"
    assert_equal "Enemy created successfully!", flash[:notice]
  end

  test "should update enemy" do
    sign_up_with_other_user

    put enemy_path(enemy), params: {
      character: {
        pathfinder_basic_attributes: {"name": "Tolo"},
        image: ""
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Tolo"
    assert_equal "Enemy successfully updated!", flash[:notice]
  end

  test "should not update character which does not belong to the user" do
    sign_up

    put enemy_path(enemy), params: {
      character: {
        name: "Tolo"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Enemies"
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should destroy enemy" do
    sign_up_with_other_user

    assert_difference("Character.count", -1) do
      delete enemy_path(enemy)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Enemies"
    assert_equal "Enemy successfully deleted!", flash[:notice]
  end

  test "should not destroy character which does not belong to the user" do
    sign_up

    assert_no_difference("Character.count") do
      delete enemy_path(enemy)
    end

    assert_response :redirect
    follow_redirect!
    assert_select "h1", "Enemies"
    assert_equal "You do not have permission.", flash[:alert]
  end
end

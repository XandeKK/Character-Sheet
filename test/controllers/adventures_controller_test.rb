require "test_helper"

class AdventuresControllerTest < ActionDispatch::IntegrationTest
  def adventure
    adventures(:one)
  end

  test "should get index" do
    sign_up

    get adventures_path
    assert_response :success
  end

  test "should get show" do
    sign_up

    get adventure_path(adventure)
    assert_response :success
  end

  test "should not get show adventure which does not belong to the user" do
    sign_up_with_other_user

    get adventure_path(adventure)
    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should get new" do
    sign_up

    get new_adventure_path
    assert_response :success
  end

  test "should create adventure" do
    sign_up

    assert_difference("Adventure.count") do
      post adventures_path, params: {
        adventure: {
          name: "Pokemon",
          password: "pichu"
        }
      }
    end
    assert_response :redirect
    assert_equal "Adventure created successfully", flash[:notice]
  end

  test "should not create adventure without name" do
    sign_up

    assert_no_difference("Adventure.count") do
      post adventures_path, params: {
        adventure: {
          name: nil,
          password: "pichu"
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    sign_up

    get edit_adventure_path(adventure)
    assert_response :success
  end

  test "should not get edit adventure which does not belong to the user" do
    sign_up_with_other_user

    get edit_adventure_path(adventure)
    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should update adventure" do
    sign_up

    put adventure_path(adventure), params: {
      adventure: {
        name: "Bye world",
        password: "end"
      }
    }

    assert_response :redirect
    assert_equal "Adventure successfully updated", flash[:notice]
  end

  test "should not update adventure without name" do
    sign_up

    put adventure_path(adventure), params: {
      adventure: {
        name: nil,
        password: "end"
      }
    }

    assert_response :unprocessable_entity
  end

  test "should not update adventure which does not belong to the user" do
    sign_up_with_other_user

    put adventure_path(adventure), params: {
      adventure: {
        name: "Bye world",
        password: "end"
      }
    }

    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should destroy adventure" do
    sign_up

    assert_difference("Adventure.count", -1) do
      delete adventure_path(adventure)
    end

    assert_response :redirect
    assert_equal "Adventure successfully deleted", flash[:notice]
  end

  test "should destroy adventure which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("Adventure.count") do
      delete adventure_path(adventure)
    end

    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
  end

end
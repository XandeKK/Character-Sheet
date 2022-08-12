require "test_helper"

class AdventureParticipationControllerTest < ActionDispatch::IntegrationTest
  test "should create adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count") do
      post create_adventure_participation_path(adventures(:one), format: :turbo_stream), params: {
        adventure_participation: {
          character_id: characters(:one).id
        }
      }
    end
    assert_response :success
    assert_select 'turbo-stream[action="replace"]'
    assert_select "button[character_id=#{characters(:one).id}]"
  end

  test "should not create adventure participation which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("AdventureParticipation.count") do
      post create_adventure_participation_path(adventures(:one), format: :turbo_stream), params: {
        adventure_participation: {
          character_id: characters(:one).id
        }
      }
    end
    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
    follow_redirect!
    assert_select "h1", "Adventures"
    end

  test "should not create adventure participation without character" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      post create_adventure_participation_path(adventures(:one), format: :turbo_stream), params: {
        adventure_participation: {
          character_id: ''
        }
      }
    end
    assert_response :unprocessable_entity
    assert_equal @response.body, ""
  end

  test "should destroy adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count", -1) do
      delete destroy_adventure_participation_path(
        character_id: characters(:one).id,
        id: adventure_participations(:one).adventure,
        format: :turbo_stream
      )
    end

    assert_response :ok
    assert_select "turbo-stream[action=update]"
    assert_select "turbo-stream[target=button_character_#{characters(:one).id}]"
  end

  test "should destroy adventure participation which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("AdventureParticipation.count") do
      delete destroy_adventure_participation_path(
        character_id: characters(:one).id,
        id: adventure_participations(:one).adventure,
        format: :turbo_stream
      )
    end

    assert_response :redirect
    assert_equal "You do not have permission.", flash[:alert]
    follow_redirect!
    assert_select "h1", "Adventures"
  end
end

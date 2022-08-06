require "test_helper"

class AdventureParticipationControllerTest < ActionDispatch::IntegrationTest
  test "should create adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count") do
      post create_adventure_participation_path(adventures(:one)), params: {
        adventure_participation: {
          character_id: characters(:one).id
        }
      }
    end
    assert_response :success
  end

  test "should not create adventure participation which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("AdventureParticipation.count") do
      post create_adventure_participation_path(adventures(:one)), params: {
        adventure_participation: {
          character_id: characters(:one).id
        }
      }
    end
    assert_response :unprocessable_entity
    assert_equal "You do not have permission.", flash[:alert]
  end

  test "should not create adventure participation without character" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      post create_adventure_participation_path(adventures(:one)), params: {
        adventure_participation: {
          character_id: ''
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should destroy adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count", -1) do
      delete destroy_adventure_participation_path(
        adventure_participation_id: adventure_participations(:one),
        id: adventure_participations(:one).adventure
      )
    end

    assert_response :ok
  end

  test "should destroy adventure participation which does not belong to the user" do
    sign_up_with_other_user

    assert_no_difference("AdventureParticipation.count") do
      delete destroy_adventure_participation_path(
        adventure_participation_id: adventure_participations(:one),
        id: adventure_participations(:one).adventure
      )
    end

    assert_response :unprocessable_entity
    assert_equal "You do not have permission.", flash[:alert]
  end
end

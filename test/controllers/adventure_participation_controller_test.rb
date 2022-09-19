require "test_helper"

class AdventureParticipationControllerTest < ActionDispatch::IntegrationTest
  test "should create adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count") do
      post adventure_participation_path, params: {
        character_id: characters(:one).id,
        adventure_id: adventures(:two).id
      }
    end
    assert_response :success
  end

  test "should destroy adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count", -1) do
      delete adventure_participation_path, params: {
        character_id: characters(:one).id,
        adventure_id: adventures(:one).id
      }
    end
    assert_response :success
  end
end

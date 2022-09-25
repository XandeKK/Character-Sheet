require "test_helper"

class AdventureParticipationControllerTest < ActionDispatch::IntegrationTest
  test "should create adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count") do
      post adventure_participation_path(format: :turbo_stream), params: {
        character_id: characters(:one).id,
        adventure_id: adventures(:two).id
      }
    end
    assert_response :success
  end

  test "shouldn't create adventure participation with character id invalid" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      post adventure_participation_path(format: :turbo_stream), params: {
        character_id: - 302,
        adventure_id: adventures(:two).id
      }
    end
    assert_response :unprocessable_entity
  end

  test "shouldn't create adventure participation with adventure id invalid" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      post adventure_participation_path(format: :turbo_stream), params: {
        character_id: characters(:one).id,
        adventure_id: -231
      }
    end
    assert_response :unprocessable_entity
  end

  test "shouldn't create adventure participation with character id and adventure id invalid" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      post adventure_participation_path(format: :turbo_stream), params: {
        character_id: - 302,
        adventure_id: -2091
      }
    end
    assert_response :unprocessable_entity
  end

  test "should destroy adventure participation" do
    sign_up

    assert_difference("AdventureParticipation.count", -1) do
      delete adventure_participation_path(format: :turbo_stream), params: {
        character_id: characters(:one).id,
        adventure_id: adventures(:one).id
      }
    end
    assert_response :success
  end

  test "shouldn't destroy adventure participation with character id invalid" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      delete adventure_participation_path(format: :turbo_stream), params: {
        character_id: -231,
        adventure_id: adventures(:one).id
      }
    end
    assert_response :unprocessable_entity
  end

  test "shouldn't destroy adventure participation with adventure id invalid" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      delete adventure_participation_path(format: :turbo_stream), params: {
        character_id: characters(:one).id,
        adventure_id: -23
      }
    end
    assert_response :unprocessable_entity
  end

  test "shouldn't destroy adventure participation with character id and adventure id invalid" do
    sign_up

    assert_no_difference("AdventureParticipation.count") do
      delete adventure_participation_path(format: :turbo_stream), params: {
        character_id: -231,
        adventure_id: -23
      }
    end
    assert_response :unprocessable_entity
  end
end

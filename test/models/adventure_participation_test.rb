require "test_helper"

class AdventureParticipationTest < ActiveSupport::TestCase
  def setup
    @adventure_participation = AdventureParticipation.new(
      character: characters(:one),
      adventure: adventures(:one)
    )
  end

  test "should be valid" do
    assert @adventure_participation.valid?, "Did not validate with adventure participation valid"
  end

  test "should be invalid without character" do
    @adventure_participation.character = nil
    assert @adventure_participation.invalid?, "Validated the adventure participation without character"
  end

  test "should be invalid without adventure" do
    @adventure_participation.adventure = nil
    assert @adventure_participation.invalid?, "Validated the adventure participation without adventure"
  end

  test "should save" do
    assert_difference("AdventureParticipation.count") do
      assert @adventure_participation.save, "Did not save with adventure participation valid"
    end
  end

  test "should destroy" do
    assert_difference("AdventureParticipation.count", -1) do
      assert adventure_participations(:one).destroy, "Did not destroy adventure participation"
    end
  end
end

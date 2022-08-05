require "test_helper"

class AdventureParticipationTest < ActiveSupport::TestCase
  def setup
    @adventure_participation = AdventureParticipation.new(
      adventure: adventures(:one),
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @adventure_participation.valid?
  end

  test "should be invalid without character" do
    @adventure_participation.character = nil
    assert @adventure_participation.invalid?
  end

  test "should be invalid without adventure" do
    @adventure_participation.adventure = nil
    assert @adventure_participation.invalid?
  end

  test "should save" do
    assert_difference("AdventureParticipation.count") do
      assert @adventure_participation.save
    end
  end

  test "should destroy" do
    assert_difference("AdventureParticipation.count", -1) do
      assert adventures(:one).destroy
    end
  end
end

require "test_helper"

class Pathfinder::RangedStrikeTest < ActiveSupport::TestCase
  def setup
    @ranged_strike = Pathfinder::RangedStrike.new(
      weapon: "",
      weapon_dexterity: "",
      proficiency: 0,
      item: 0,
      dice: 0,
      types: "",
      special: "",
      weapon_specialization: "",
      range: "",
      traits: "",
      other: "",
      notes: "",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @ranged_strike.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::RangedStrike.count") do
      assert @ranged_strike.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::RangedStrike.count", -1) do
      assert pathfinder_ranged_strikes(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @ranged_strike.character = nil
    assert @ranged_strike.invalid?, "Validated the character without character"
  end
end

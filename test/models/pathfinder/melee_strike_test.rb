require "test_helper"

class Pathfinder::MeleeStrikeTest < ActiveSupport::TestCase
  def setup
    @melee_strike = Pathfinder::MeleeStrike.new(
      weapon: "",
      weapon_strength: "",
      proficiency: 0,
      item: 0,
      dice: 0,
      types: "",
      damage_strength: "",
      weapon_specialization: "",
      traits: "",
      other: "",
      notes: "",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @melee_strike.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::MeleeStrike.count") do
      assert @melee_strike.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::MeleeStrike.count", -1) do
      assert pathfinder_melee_strikes(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @melee_strike.character = nil
    assert @melee_strike.invalid?, "Validated the character without character"
  end
end

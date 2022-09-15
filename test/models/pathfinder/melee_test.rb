require "test_helper"

class Pathfinder::MeleeTest < ActiveSupport::TestCase
  def setup
    @melee = Pathfinder::Melee.new(
      name: "Tua mãe",
      qty: 54,
      types: "Perfurante",
      proficiency: 3,
      traits: "s",
      weapon_specialization: 0,
      die: "1d8",
      item: 3,
      other: "str",
      notes: "str",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @melee.valid?, "Did not validate with melee valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Melee.count") do
      assert @melee.save, "Did not save with melee valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Melee.count", -1) do
      assert pathfinder_melees(:one).destroy, "Did not destroy melee"
    end
  end

  test "should be invalid without character" do
    @melee.character = nil
    assert @melee.invalid?, "Validated the character without character"
  end
end

require "test_helper"

class Pathfinder::WeaponProficTest < ActiveSupport::TestCase
  def setup
    @weapon_proficiency = Pathfinder::WeaponProfic.new(
      name: "simple",
      proficiency: 0,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @weapon_proficiency.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::WeaponProfic.count") do
      assert @weapon_proficiency.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::WeaponProfic.count", -1) do
      assert pathfinder_weapon_profics(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @weapon_proficiency.character = nil
    assert @weapon_proficiency.invalid?, "Validated the character without character"
  end
end

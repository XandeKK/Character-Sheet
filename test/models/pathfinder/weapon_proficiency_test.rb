require "test_helper"

class Pathfinder::WeaponProficiencyTest < ActiveSupport::TestCase
  def setup
    @weapon_proficiency = Pathfinder::WeaponProficiency.new(
      name: "Martial",
      proficiency: 10,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @weapon_proficiency.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::WeaponProficiency.count") do
      assert @weapon_proficiency.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::WeaponProficiency.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @weapon_proficiency.character = nil
    assert @weapon_proficiency.invalid?, "Validated the character without character"
  end

end

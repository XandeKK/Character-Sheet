require "test_helper"

class Pathfinder::HitPointTest < ActiveSupport::TestCase
  def setup
    @hit_point = Pathfinder::HitPoint.new(
      max_hp: 100,
      current_hp: 50,
      temporary_hp: 1,
      resistances_and_immunities: "Poison",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @hit_point.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::HitPoint.count") do
      assert @hit_point.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::HitPoint.count", -1) do
      assert pathfinder_hit_points(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @hit_point.character = nil
    assert @hit_point.invalid?, "Validated the character without character"
  end
end

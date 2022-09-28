require "test_helper"

class Pathfinder::DefenseTest < ActiveSupport::TestCase
  def setup
    @defense = Pathfinder::Defense.new(
      max_hp: 2,
      current_hp: 2,
      ancestry_hp: 2,
      class_hp: 2,
      temp_hp: 2,
      resistances_and_immunities: "Mulato",
      conditions: "Neutro",
      dying: 1,
      wounded: 1,
      armor_class_item: 1,
      armor_class_proficiency: 1,
      max_dex: 0,
      heavy_proficiency: 1,
      medium_proficiency: 1,
      light_proficiency: 1,
      unarmored_proficiency: 1,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @defense.valid?, "Did not validate with defense valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Defense.count") do
      assert @defense.save, "Did not save with defense valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Defense.count", -1) do
      assert pathfinder_defenses(:one).destroy, "Did not destroy defense"
    end
  end

  test "should be invalid without character" do
    @defense.character = nil
    assert @defense.invalid?, "Validated the defense without character"
  end
end

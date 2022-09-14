require "test_helper"

class Pathfinder::SpellCasterTest < ActiveSupport::TestCase
  def setup
    @spellcaster = Pathfinder::SpellCaster.new(
      magic_tradition: "Arcane",
      spellcasting_type: "Prepared",
      attack_proficiency: 1,
      attack_bonus: 1,
      attack_penalty: 1,
      cd_proficiency: 1,
      cd_bonus: 1,
      cd_penalty: 1,
      max_focus_points: 1,
      current_focus_points: 1,
      level_0: 1,
      level_1: 1,
      level_2: 1,
      level_3: 1,
      level_4: 1,
      level_5: 1,
      level_6: 1,
      level_7: 1,
      level_8: 1,
      level_9: 1,
      level_10: 1,
      notes: "",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @spellcaster.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::SpellCaster.count") do
      assert @spellcaster.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::SpellCaster.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @spellcaster.character = nil
    assert @spellcaster.invalid?, "Validated the character without character"
  end

end

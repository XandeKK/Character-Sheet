require "test_helper"

class Pathfinder::SkillTest < ActiveSupport::TestCase
  def setup
    @skill = Pathfinder::Skill.new(
      name: "Acrobatics",
      note: "",
      proficiency: 3,
      key_ability: 3,
      item: 2,
      armor: 2,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @skill.valid?, "Did not validate with skill valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Skill.count") do
      assert @skill.save, "Did not save with skill valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Skill.count", -1) do
      assert pathfinder_skills(:one).destroy, "Did not destroy skill"
    end
  end

  test "should be invalid without character" do
    @skill.character = nil
    assert @skill.invalid?, "Validated the skill without character"
  end

end

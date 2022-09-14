require "test_helper"

class Pathfinder::SkillTest < ActiveSupport::TestCase
  def setup
    @skill = Pathfinder::Skill.new(
      name: "Acrobatics",
      note: "",
      proficiency: 3,
      item: 2,
      armor: 2,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @skill.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Skill.count") do
      assert @skill.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Skill.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @skill.character = nil
    assert @skill.invalid?, "Validated the character without character"
  end

end

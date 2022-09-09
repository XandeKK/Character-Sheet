require "test_helper"

class Pathfinder::AbilityTest < ActiveSupport::TestCase
  def setup
    @ability = Pathfinder::Ability.new(
      strength: 10,
      dexterity: 20,
      constitution: 13,
      intelligence: 15,
      wisdom: 9,
      charisma: 13,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @ability.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Ability.count") do
      assert @ability.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Ability.count", -1) do
      assert pathfinder_abilities(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @ability.character = nil
    assert @ability.invalid?, "Validated the character without character"
  end
end

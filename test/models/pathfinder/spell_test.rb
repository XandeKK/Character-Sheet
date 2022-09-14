require "test_helper"

class Pathfinder::SpellTest < ActiveSupport::TestCase
  def setup
    @spell = Pathfinder::Spell.new(
      level: 1,
      name: "Bola",
      notes: "",
      prepared: 1,
      spell_component: "Material",
      action: 1,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @spell.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Spell.count") do
      assert @spell.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Spell.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @spell.character = nil
    assert @spell.invalid?, "Validated the character without character"
  end

end

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
      duration: 0,
      range: 0,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @spell.valid?, "Did not validate with spell valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Spell.count") do
      assert @spell.save, "Did not save with spell valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Spell.count", -1) do
      assert pathfinder_spells(:one).destroy, "Did not destroy spell"
    end
  end

  test "should be invalid without character" do
    @spell.character = nil
    assert @spell.invalid?, "Validated the spell without character"
  end

end

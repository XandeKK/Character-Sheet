require "test_helper"

class Pathfinder::InnateSpellTest < ActiveSupport::TestCase
  def setup
    @innate_spell = Pathfinder::InnateSpell.new(
      name: "Humm",
      notes: "MyText",
      frequency: 1,
      spell_component: "Material",
      duration: 0,
      range: 0,
      action: 1,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @innate_spell.valid?, "Did not validate with innate_spell valid"
  end

  test "should save" do
    assert_difference("Pathfinder::InnateSpell.count") do
      assert @innate_spell.save, "Did not save with innate_spell valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::InnateSpell.count", -1) do
      assert pathfinder_innate_spells(:one).destroy, "Did not destroy innate_spell"
    end
  end

  test "should be invalid without character" do
    @innate_spell.character = nil
    assert @innate_spell.invalid?, "Validated the innate_spell without character"
  end

end

require "test_helper"

class Pathfinder::FocusSpellTest < ActiveSupport::TestCase
  def setup
    @focus_spell = Pathfinder::FocusSpell.new(
      name: "Ok",
      notes: "MyText",
      spell_component: "Material",
      action: 2,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @focus_spell.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::FocusSpell.count") do
      assert @focus_spell.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::FocusSpell.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @focus_spell.character = nil
    assert @focus_spell.invalid?, "Validated the character without character"
  end

end
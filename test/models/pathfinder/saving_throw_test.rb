require "test_helper"

class Pathfinder::SavingThrowTest < ActiveSupport::TestCase
  def setup
    @saving = Pathfinder::SavingThrow.new(
      fortitude_total: 5,
      reflex_total: 5,
      will_total: 5,
      fortitude_proficiency: 5,
      reflex_proficiency: 5,
      will_proficiency: 5,
      fortitude_item: 5,
      reflex_item: 5,
      will_item: 5,
      fortitude_misc: 5,
      reflex_misc: 5,
      will_misc: 5,
      fortitude_penalty: 5,
      reflex_penalty: 5,
      will_penalty: 2,
      saving_throw_notes: "Bla",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @saving.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::SavingThrow.count") do
      assert @saving.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::SavingThrow.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @saving.character = nil
    assert @saving.invalid?, "Validated the character without character"
  end
end

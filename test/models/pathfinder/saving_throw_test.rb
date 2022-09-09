require "test_helper"

class Pathfinder::SavingThrowTest < ActiveSupport::TestCase
  def setup
    @saving_throw = Pathfinder::SavingThrow.new(
      fortitude: 0,
      fortitude_item: 0,
      will: 0,
      will_item: 0,
      reflex: 0,
      reflex_item: 0,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @saving_throw.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::SavingThrow.count") do
      assert @saving_throw.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::SavingThrow.count", -1) do
      assert pathfinder_saving_throws(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @saving_throw.character = nil
    assert @saving_throw.invalid?, "Validated the character without character"
  end
end


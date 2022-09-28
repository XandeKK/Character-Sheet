require "test_helper"

class DiceTest < ActiveSupport::TestCase
  def setup
    @dice = Dice.new(
      name: "atack",
      notation: "1d20",
      notes: "a simple attack",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @dice.valid?, "Did not validate with dice valid"
  end

  test "should save" do
    assert_difference("Dice.count") do
      assert @dice.save, "Did not save with dice valid"
    end
  end

  test "should destroy" do
    assert_difference("Dice.count", -1) do
      assert dices(:one).destroy, "Did not destroy dice"
    end
  end

  test "should be invalid without character" do
    @dice.character = nil
    assert @dice.invalid?, "Validated the dice without character"
  end

  test "should be invalid without name" do
    @dice.name = nil
    assert @dice.invalid?, "Validated the dice without name"
  end

  test "should be invalid without notation" do
    @dice.notation = nil
    assert @dice.invalid?, "Validated the dice without notation"
  end

  # A future test notation
  # where will check if the notation is correct
end

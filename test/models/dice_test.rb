require "test_helper"

class DiceTest < ActiveSupport::TestCase
  def setup
    @dice = Dice.new(
      notation: "1d20",
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

  test "should be invalid without dice category" do
    @dice.character = nil
    assert @dice.invalid?, "Validated the dice without character"
  end
end

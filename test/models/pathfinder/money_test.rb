require "test_helper"

class Pathfinder::MoneyTest < ActiveSupport::TestCase
  def setup
    @money = Pathfinder::Money.new(
      pp: 0,
      gp: 0,
      sp: 0,
      cp: 0,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @money.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Money.count") do
      assert @money.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Money.count", -1) do
      assert pathfinder_money(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @money.character = nil
    assert @money.invalid?, "Validated the character without character"
  end
end

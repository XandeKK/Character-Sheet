require "test_helper"

class Pathfinder::MoneyTest < ActiveSupport::TestCase
  def setup
    @money = Pathfinder::Money.new(
      platinum: 100,
      gold: 100,
      silver: 100,
      copper: 100,
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
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @money.character = nil
    assert @money.invalid?, "Validated the character without character"
  end
end

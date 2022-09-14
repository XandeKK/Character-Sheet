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
    assert @money.valid?, "Did not validate with money valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Money.count") do
      assert @money.save, "Did not save with money valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Money.count", -1) do
      assert pathfinder_money(:one).destroy, "Did not destroy money"
    end
  end

  test "should be invalid without character" do
    @money.character = nil
    assert @money.invalid?, "Validated the money without character"
  end
end

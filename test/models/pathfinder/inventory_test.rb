require "test_helper"

class Pathfinder::InventoryTest < ActiveSupport::TestCase
  def setup
    @inventory = Pathfinder::Inventory.new(
      name: "",
      amount: 0,
      bulk: 0,
      notes: "",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @inventory.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Inventory.count") do
      assert @inventory.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Inventory.count", -1) do
      assert pathfinder_inventories(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @inventory.character = nil
    assert @inventory.invalid?, "Validated the character without character"
  end
end

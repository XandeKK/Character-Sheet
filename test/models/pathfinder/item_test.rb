require "test_helper"

class Pathfinder::ItemTest < ActiveSupport::TestCase
  def setup
    @item = Pathfinder::Item.new(
      name: "Chef",
      quatity: 3,
      weight: 1,
      notes: "Porque?",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @item.valid?, "Did not validate with item valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Item.count") do
      assert @item.save, "Did not save with item valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Item.count", -1) do
      assert pathfinder_items(:one).destroy, "Did not destroy item"
    end
  end

  test "should be invalid without character" do
    @item.character = nil
    assert @item.invalid?, "Validated the item without character"
  end
end

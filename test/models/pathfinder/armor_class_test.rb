require "test_helper"

class Pathfinder::ArmorClassTest < ActiveSupport::TestCase
  def setup
    @armor_class = Pathfinder::ArmorClass.new(
      capable: 0,
      proficiency: 0,
      unarmored: 0,
      light:0,
      medium:0,
      heavy:0,
      shield: 0,
      hardness: 0,
      maxHp: 0,
      broken_threshold: 0,
      current_hp: 0,
      item: 0,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @armor_class.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::ArmorClass.count") do
      assert @armor_class.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::ArmorClass.count", -1) do
      assert pathfinder_armor_classes(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @armor_class.character = nil
    assert @armor_class.invalid?, "Validated the character without character"
  end
end

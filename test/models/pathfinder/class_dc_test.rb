require "test_helper"

class Pathfinder::ClassDcTest < ActiveSupport::TestCase
  def setup
    @class_dc = Pathfinder::ClassDc.new(
      key_ability: "Charisma",
      item: 0,
      proficiency: 4,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @class_dc.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::ClassDc.count") do
      assert @class_dc.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::ClassDc.count", -1) do
      assert pathfinder_class_dcs(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @class_dc.character = nil
    assert @class_dc.invalid?, "Validated the character without character"
  end
end

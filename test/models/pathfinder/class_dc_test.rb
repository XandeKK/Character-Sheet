require "test_helper"

class Pathfinder::ClassDcTest < ActiveSupport::TestCase
  def setup
    @class_dc = Pathfinder::ClassDc.new(
      item: 1,
      proficiency: 1,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @class_dc.valid?, "Did not validate with class_dc valid"
  end

  test "should save" do
    assert_difference("Pathfinder::ClassDc.count") do
      assert @class_dc.save, "Did not save with class_dc valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::ClassDc.count", -1) do
      assert pathfinder_class_dcs(:one).destroy, "Did not destroy class_dc"
    end
  end

  test "should be invalid without character" do
    @class_dc.character = nil
    assert @class_dc.invalid?, "Validated the class_dc without character"
  end

end

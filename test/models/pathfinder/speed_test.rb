require "test_helper"

class Pathfinder::SpeedTest < ActiveSupport::TestCase
  def setup
    @speed = Pathfinder::Speed.new(
      feet: 1,
      movement_types: "Bla",
      notes: "bal bla bla",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @speed.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Speed.count") do
      assert @speed.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Speed.count", -1) do
      assert pathfinder_speeds(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @speed.character = nil
    assert @speed.invalid?, "Validated the character without character"
  end
end
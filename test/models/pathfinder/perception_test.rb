require "test_helper"

class Pathfinder::PerceptionTest < ActiveSupport::TestCase
  def setup
    @perception = Pathfinder::Perception.new(
      item: 1,
      proficiency: 1,
      senses: "Cego",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @perception.valid?, "Did not validate with perception valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Perception.count") do
      assert @perception.save, "Did not save with perception valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Perception.count", -1) do
      assert pathfinder_perceptions(:one).destroy, "Did not destroy perception"
    end
  end

  test "should be invalid without character" do
    @perception.character = nil
    assert @perception.invalid?, "Validated the perception without character"
  end

end

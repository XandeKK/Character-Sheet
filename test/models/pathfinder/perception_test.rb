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
    assert @perception.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Perception.count") do
      assert @perception.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Perception.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @perception.character = nil
    assert @perception.invalid?, "Validated the character without character"
  end

end

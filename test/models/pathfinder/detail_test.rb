require "test_helper"

class Pathfinder::DetailTest < ActiveSupport::TestCase
  def setup
    @detail = Pathfinder::Detail.new(
      name: "Mano brow",
      class_name: "Ninja",
      ancestry: "Hero",
      heritage: "Human",
      level: 2,
      hero_points: 1,
      alignment: "Good",
      size: 180,
      background: "Amnesia",
      traits: "Sei lá",
      experience_points: 100,
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @detail.valid?, "Did not validate with character detail valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Detail.count") do
      assert @detail.save, "Did not save with character detail valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Detail.count", -1) do
      assert pathfinder_details(:one).destroy, "Did not destroy character detail"
    end
  end

  test "should be invalid without name" do
    @detail.name = nil
    assert @detail.invalid?, "Validated the character detail without name"
  end

  test "should be invalid without character" do
    @detail.character = nil
    assert @detail.invalid?, "Validated the character detail without character"
  end

  test "should be valid only with the name filled in" do
    @detail.class_name = nil
    @detail.ancestry = nil
    @detail.heritage = nil
    @detail.level = nil
    @detail.hero_points = nil
    @detail.alignment = nil
    @detail.size = nil
    @detail.background = nil
    @detail.traits = nil
    @detail.experience_points = nil
    assert @detail.valid?, "Did not validate the character detail"
  end
end

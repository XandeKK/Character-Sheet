require "test_helper"

class Pathfinder::FeatTest < ActiveSupport::TestCase
  def setup
    @feat = Pathfinder::Feat.new(
      name: "Mas que pena",
      types: "bonus",
      notes: "Um historia longa",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @feat.valid?, "Did not validate with feat valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Feat.count") do
      assert @feat.save, "Did not save with feat valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Feat.count", -1) do
      assert pathfinder_feats(:one).destroy, "Did not destroy feat"
    end
  end

  test "should be invalid without character" do
    @feat.character = nil
    assert @feat.invalid?, "Validated the feat without character"
  end
end

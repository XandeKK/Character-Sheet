require "test_helper"

class Pathfinder::FeatTest < ActiveSupport::TestCase
  def setup
    @feat = Pathfinder::Feat.new(
      level: "",
      name: "",
      notes: "",
      character: characters(:one),
      pathfinder_feat_category: pathfinder_feat_categories(:one)
    )
  end

  test "should be valid" do
    assert @feat.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Feat.count") do
      assert @feat.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Feat.count", -1) do
      assert pathfinder_feats(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @feat.character = nil
    assert @feat.invalid?, "Validated the character without character"
  end

  test "should be invalid without feat categories" do
    @feat.pathfinder_feat_category = nil
    assert @feat.invalid?, "Validated the character without feat categories"
  end
end

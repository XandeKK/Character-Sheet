require "test_helper"

class Pathfinder::FeatCategoryTest < ActiveSupport::TestCase
  def setup
    @feat_category = Pathfinder::FeatCategory.new(
      name: "Ancestry"
    )
  end

  test "should be valid" do
    assert @feat_category.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::FeatCategory.count") do
      assert @feat_category.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::FeatCategory.count", -1) do
      assert pathfinder_feat_categories(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without name" do
    @feat_category.name = nil
    assert @feat_category.invalid?, "Validated the character without name"
  end
end

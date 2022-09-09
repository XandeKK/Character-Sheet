require "test_helper"

class CharacterCategoryTest < ActiveSupport::TestCase
  def setup
    @character_category = CharacterCategory.new(
      name: "Npc"
    )
  end

  test "should be valid" do
    assert @character_category.valid?, "Did not validate with character category valid"
  end

  test "should be invalid" do
    @character_category.name = nil
    assert @character_category.invalid?, "Validated the character category without name"
  end

  test "should save" do
    assert_difference("CharacterCategory.count") do
      assert @character_category.save, "Did not save with character category valid"
    end
  end
end

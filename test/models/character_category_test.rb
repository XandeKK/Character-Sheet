require "test_helper"

class CharacterCategoryTest < ActiveSupport::TestCase
  def setup
    @character_category = CharacterCategory.new(
      name: "Npc"
    )
  end

  test "should be valid" do
    assert @character_category.valid?
  end

  test "should be invalid" do
    @character_category.name = nil
    assert @character_category.invalid?
  end

  test "should save" do
    assert_difference("CharacterCategory.count") do
      assert @character_category.save
    end
  end
end

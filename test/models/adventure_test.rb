require "test_helper"

class AdventureTest < ActiveSupport::TestCase
  def setup
    @adventure = Adventure.new(
      name: "One piece",
      password: "Luffy",
      unique_name: "randomname123",
      online: false,
      slug: "one-piece",
      user: users(:one)
    )
  end

  test "should be valid" do
    assert @adventure.valid?, "Did not validate with adventure valid"
  end

  test "should be valid without slug" do
    @adventure.slug = nil
    assert @adventure.valid?, "Validated the adventure without slug"
  end

  test "should be invalid without name" do
    @adventure.name = nil
    assert @adventure.invalid?, "Validated the adventure without name"
  end

  test "should be invalid without unique_name" do
    @adventure.unique_name = nil
    assert @adventure.invalid?, "Validated the adventure without unique_name"
  end

  test "should be invalid without user" do
    @adventure.user = nil
    assert @adventure.invalid?, "Validated the adventure without user"
  end

  test "should save" do
    assert_difference("Adventure.count") do
      assert @adventure.save, "Did not save with adventure valid"
    end
  end

  test "should destroy" do
    assert_difference("Adventure.count", -1) do
      assert adventures(:one).destroy, "Did not destroy adventure"
    end
  end
end

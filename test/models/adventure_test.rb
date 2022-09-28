require "test_helper"

class AdventureTest < ActiveSupport::TestCase
  def setup
    @adventure = Adventure.new(
      name: "One piece",
      password: "Luffy",
      server_name: "randomname123",
      user: users(:one)
    )
  end

  test "should be valid" do
    assert @adventure.valid?, "Did not validate with adventure valid"
  end

  test "should be invalid without name" do
    @adventure.name = nil
    assert @adventure.invalid?, "Validated the adventure without name"
  end

  test "should be invalid without server name" do
    @adventure.server_name = nil
    assert @adventure.invalid?, "Validated the adventure without server name"
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

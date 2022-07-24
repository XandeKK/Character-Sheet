require "test_helper"

class AdventureTest < ActiveSupport::TestCase
  def setup
    @adventure = Adventure.new(
      name: "One piece",
      password: "Luffy",
      unique_name: "randomname123",
      online: false,
      user: users(:one)
    )
  end

  test "should be valid" do
    assert @adventure.valid?
  end

  test "should be invalid without name" do
    @adventure.name = nil
    assert @adventure.invalid?
  end

  test "should be invalid without unique_name" do
    @adventure.unique_name = nil
    assert @adventure.invalid?
  end

  test "should be invalid without user" do
    @adventure.user = nil
    assert @adventure.invalid?
  end

  test "should save" do
    assert_difference("Adventure.count") do
      assert @adventure.save
    end
  end

  test "should destroy" do
    assert_difference("Adventure.count", -1) do
      assert adventures(:one).destroy
    end
  end
end

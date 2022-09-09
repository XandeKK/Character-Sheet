require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  def setup
    @character = Character.new(
      user: users(:one),
      character_category: character_categories(:one),
      character_system: character_systems(:one)
    )
  end

  test "should be valid" do
    assert @character.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Character.count") do
      assert @character.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Character.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without user" do
    @character.user = nil
    assert @character.invalid?, "Validated the character without user"
  end

  test "should be invalid without character category" do
    @character.character_category = nil
    assert @character.invalid?, "Validated the character without character category"
  end

  test "should be invalid without character system" do
    @character.character_system = nil
    assert @character.invalid?, "Validated the character without character system"
  end
end

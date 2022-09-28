require "test_helper"

class CharacterSystemTest < ActiveSupport::TestCase
  def setup
    @character_system = CharacterSystem.new(
      name: "Pathfinder"
    )
  end

  test "should be valid" do
    assert @character_system.valid?, "Did not validate with character system valid"
  end

  test "should be invalid" do
    @character_system.name = nil
    assert @character_system.invalid?, "Validated the character system without name"
  end

  test "should save" do
    assert_difference("CharacterSystem.count") do
      assert @character_system.save, "Did not save with character system valid"
    end
  end
end

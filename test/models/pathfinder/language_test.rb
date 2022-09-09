require "test_helper"

class Pathfinder::LanguageTest < ActiveSupport::TestCase
  def setup
    @language = Pathfinder::Language.new(
      name: "Portuguese",
      notes: "",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @language.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Language.count") do
      assert @language.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Language.count", -1) do
      assert pathfinder_languages(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @language.character = nil
    assert @language.invalid?, "Validated the character without character"
  end
end

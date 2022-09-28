require "test_helper"

class Pathfinder::LanguageTest < ActiveSupport::TestCase
  def setup
    @language = Pathfinder::Language.new(
      name: "Mas que pena",
      notes: "Um historia longa",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @language.valid?, "Did not validate with language valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Language.count") do
      assert @language.save, "Did not save with language valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Language.count", -1) do
      assert pathfinder_languages(:one).destroy, "Did not destroy language"
    end
  end

  test "should be invalid without character" do
    @language.character = nil
    assert @language.invalid?, "Validated the language without character"
  end
end

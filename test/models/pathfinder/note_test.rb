require "test_helper"

class Pathfinder::NoteTest < ActiveSupport::TestCase
  def setup
    @note = Pathfinder::Note.new(
      name: "Paul",
      note: "um cara trouxa",
      character: characters(:one)
    )
  end

  test "should be valid" do
    assert @note.valid?, "Did not validate with character valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Note.count") do
      assert @note.save, "Did not save with character valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Note.count", -1) do
      assert characters(:one).destroy, "Did not destroy character"
    end
  end

  test "should be invalid without character" do
    @note.character = nil
    assert @note.invalid?, "Validated the character without character"
  end

end

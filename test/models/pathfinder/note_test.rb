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
    assert @note.valid?, "Did not validate with note valid"
  end

  test "should save" do
    assert_difference("Pathfinder::Note.count") do
      assert @note.save, "Did not save with note valid"
    end
  end

  test "should destroy" do
    assert_difference("Pathfinder::Note.count", -1) do
      assert pathfinder_notes(:one).destroy, "Did not destroy note"
    end
  end

  test "should be invalid without character" do
    @note.character = nil
    assert @note.invalid?, "Validated the note without character"
  end

end

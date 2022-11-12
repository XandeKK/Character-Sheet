# frozen_string_literal: true

require "test_helper"

class PathfinderShow::NotesComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::NotesComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::NotesComponent.new(character: character))

    character.pathfinder_notes.each do |note|
      assert_text note.name
      assert_text note.note
    end
  end

  test "should't create a PathfinderShow::NotesComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::NotesComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end

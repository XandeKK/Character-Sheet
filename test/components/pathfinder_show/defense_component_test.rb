# frozen_string_literal: true

require "test_helper"

class PathfinderShow::DefenseComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::DefenseComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::DefenseComponent.new(character: character))

    assert_text character.pathfinder_defense.current_hp
    assert_text character.pathfinder_defense.max_hp
    assert_text character.pathfinder_defense.temp_hp
    assert_text character.pathfinder_defense.resistances_and_immunities
    assert_text character.pathfinder_defense.conditions
    assert_text character.pathfinder_saving_throw.fortitude_total
    assert_text character.pathfinder_saving_throw.reflex_total
    assert_text character.pathfinder_saving_throw.will_total
    assert_text character.pathfinder_saving_throw.saving_throw_notes
  end

  test "should't create a PathfinderShow::DefenseComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::DefenseComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end

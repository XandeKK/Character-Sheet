# frozen_string_literal: true

require "test_helper"

class PathfinderShow::EquipamentComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::EquipamentComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::EquipamentComponent.new(character: character))

    character.pathfinder_items.each do |item|
      assert_text item.name
      assert_text item.quatity
    end

    assert_text character.pathfinder_money.platinum
    assert_text character.pathfinder_money.gold
    assert_text character.pathfinder_money.silver
    assert_text character.pathfinder_money.copper
  end

  test "should't create a PathfinderShow::EquipamentComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::EquipamentComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end

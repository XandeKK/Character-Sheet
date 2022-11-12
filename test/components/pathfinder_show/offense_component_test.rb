# frozen_string_literal: true

require "test_helper"

class PathfinderShow::OffenseComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::OffenseComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::OffenseComponent.new(character: character))

    character.pathfinder_melees.each do |melee|
      assert_text melee.name
      assert_text "Item: #{melee.item}"
      assert_text "Proficiency: #{melee.proficiency}"
      assert_text "Weapon specialization: #{melee.weapon_specialization}"
      assert_text melee.qty
      assert_text melee.die
      assert_text melee.types
    end

    character.pathfinder_rangeds.each do |ranged|
      assert_text ranged.name
      assert_text "Item: #{ranged.item}"
      assert_text "Proficiency: #{ranged.proficiency}"
      assert_text "Weapon specialization: #{ranged.weapon_specialization}"
      assert_text ranged.qty
      assert_text ranged.die
      assert_text ranged.types
      assert_text ranged.range
    end
  end

  test "should't create a PathfinderShow::OffenseComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::OffenseComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end

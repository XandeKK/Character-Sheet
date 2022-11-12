# frozen_string_literal: true

require "test_helper"

class PathfinderShow::BasicsComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::BasicsComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::BasicsComponent.new(character: character))

    assert_selector("#character-name", text: character.pathfinder_basic.name)
    assert_selector("h2.text-2xl", text: "#{character.pathfinder_basic.class_name}")

    assert_text character.pathfinder_basic.speed_note
    assert_text character.pathfinder_basic.speed
    assert_text character.pathfinder_basic.alignment
    assert_text character.pathfinder_basic.size
    assert_text character.pathfinder_basic.ancestry
    assert_text character.pathfinder_basic.heritage_note
    assert_text character.pathfinder_basic.heritage
    assert_text character.pathfinder_basic.background
    assert_text character.pathfinder_basic.deity
    assert_text character.pathfinder_basic.age
    assert_text character.pathfinder_basic.hero_points
    assert_text character.pathfinder_basic.description

    character.dices.each do |dice|
      assert_text dice.name
    end
  end

  test "should't create a PathfinderShow::BasicsComponent without character" do
    exception = assert_raise(ArgumentError) do
      render_inline(PathfinderShow::BasicsComponent.new)
    end

    assert_equal("missing keyword: :character", exception.message)
  end
end

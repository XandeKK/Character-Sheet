# frozen_string_literal: true

require "test_helper"

class PathfinderShow::DrawerComponentTest < ViewComponent::TestCase
  test "should create a PathfinderShow::DrawerComponent" do
    character = characters(:one)
    render_inline(PathfinderShow::DrawerComponent.new)

    assert_text "Color Dice"
    assert_text "Dice theme"
    assert_text "default"
    assert_text "blueGreenMetal"
    assert_text "diceOfRolling"
    assert_text "rock"
    assert_text "rust"
    assert_text "smooth"
    assert_text "wooden"

    ["4", "6", "8", "10", "12", "20", "100"].each do |dice|
      assert_text "1d#{dice}"
    end

    assert_text "Damage"
    assert_text "Critical"
  end
end

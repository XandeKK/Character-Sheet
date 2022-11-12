# frozen_string_literal: true

require "test_helper"

class DrawerLeftComponentTest < ViewComponent::TestCase
  test "should create a drawer left component" do
    render_inline(DrawerLeftComponent.new)

    assert_text "Menu"
    assert_text "Home"
    assert_text "Characters"
    assert_text "Players"
    assert_text "Npcs"
    assert_text "Enemies"
    assert_text "Adventures"
    assert_text "Log-out"
    assert_text "Night mode"
    assert_text "Day mode"
  end
end

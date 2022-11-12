# frozen_string_literal: true

require "test_helper"

class SideBarComponentTest < ViewComponent::TestCase
  test "should create a side bar component" do
    render_inline(SideBarComponent.new)

    [
      "basics",
      "statistics",
      "equipament",
      "defense",
      "offense",
      "skills",
      "spells",
      "notes"
    ].each do |name|
      assert_css("svg[href-spy='##{name}']")
      assert_css("a[href='##{name}']")
    end
  end
end

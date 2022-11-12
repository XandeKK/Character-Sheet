# frozen_string_literal: true

require "test_helper"

class PopoverComponentTest < ViewComponent::TestCase
  test "should create a card component" do
    render_inline(PopoverComponent.new(
      name: "sem-fim",
      content_popover: "...Se eu for sozinho acreditar..."
    ).with_content("...A vida real é assutadora..."))

    assert_text("...Se eu for sozinho acreditar...")
    assert_text("...A vida real é assutadora...")
    assert_css("span[data-popover-target='popover-sem-fim']")
    assert_css("#popover-sem-fim")
  end

  test "should create a card component without name" do
    exception = assert_raise(ArgumentError) do 
      render_inline(PopoverComponent.new(
        content_popover: "...Se eu for sozinho acreditar..."
      ).with_content("...A vida real é assutadora..."))
    end

    assert_equal("missing keyword: :name", exception.message)
  end

  test "should create a card component without content_popover" do
    exception = assert_raise(ArgumentError) do 
      render_inline(PopoverComponent.new(
        name: "sem-fim"
      ).with_content("...A vida real é assutadora..."))
    end

    assert_equal("missing keyword: :content_popover", exception.message)
  end
end

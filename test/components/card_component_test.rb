# frozen_string_literal: true

require "test_helper"

class CardComponentTest < ViewComponent::TestCase
  test "should create a card component without tabs" do
    render_inline(CardComponent.new(
      title: "basics",
      svg: "M4 22a8 8 0 1 1 16 0H4zm8-9c-3.315 0-6-2.685-6-6s2.685-6 6-6 6 2.685 6 6-2.685 6-6 6z"
    ))

    assert_text("Basics")
    assert_no_text("Character")
    assert_no_text("Ancestry")
  end

  test "should create a card component with tabs" do
    render_inline(CardComponent.new(
      title: "basics",
      svg: "M4 22a8 8 0 1 1 16 0H4zm8-9c-3.315 0-6-2.685-6-6s2.685-6 6-6 6 2.685 6 6-2.685 6-6 6z",
      tabs: ["character", "ancestry"]
    ))

    assert_text("Basics")
    assert_text("Character")
    assert_text("Ancestry")
  end

  test "should't create a card component without svg" do
    exception = assert_raise(ArgumentError) do 
      render_inline(CardComponent.new(
        title: "basics",
        tabs: ["character", "ancestry"]
      ))
    end

    assert_equal("missing keyword: :svg", exception.message)
  end

  test "should't create a card component without title" do
    exception = assert_raise(ArgumentError) do 
      render_inline(CardComponent.new(
        svg: "M4 22a8 8 0 1 1 16 0H4zm8-9c-3.315 0-6-2.685-6-6s2.685-6 6-6 6 2.685 6 6-2.685 6-6 6z",
        tabs: ["character", "ancestry"]
      ))
    end

    assert_equal("missing keyword: :title", exception.message)
  end
end

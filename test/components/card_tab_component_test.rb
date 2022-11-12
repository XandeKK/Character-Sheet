# frozen_string_literal: true

require "test_helper"

class CardTabComponentTest < ViewComponent::TestCase
  test "should create a card tab component" do
    render_inline(CardTabComponent.new(
      tab: "basics",
      hidden: false
    ).with_content("Bostil está foda."))

    assert_selector("#basics", text: "Bostil está foda.")
    assert_no_css(".hidden")
  end

  test "should create a card tab component hidden" do
    render_inline(CardTabComponent.new(
      tab: "basics",
      hidden: true
    ).with_content("Bostil está foda."))

    assert_selector("#basics", text: "Bostil está foda.")
    assert_css(".hidden")
  end

  test "should'n create a card tab component without tab" do
    exception = assert_raise(ArgumentError) do 
      render_inline(CardTabComponent.new(
        hidden: true
      ).with_content("Bostil está foda."))
    end

    assert_equal("missing keyword: :tab", exception.message)
  end

  test "should'n create a card tab component without hidden" do
    exception = assert_raise(ArgumentError) do 
      render_inline(CardTabComponent.new(
        tab: "basics"
      ).with_content("Bostil está foda."))
    end

    assert_equal("missing keyword: :hidden", exception.message)
  end
end

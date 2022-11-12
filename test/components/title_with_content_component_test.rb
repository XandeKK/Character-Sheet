# frozen_string_literal: true

require "test_helper"

class TitleWithContentComponentTest < ViewComponent::TestCase
  test "should create a title with content component with bar" do
    render_inline(TitleWithContentComponent.new(
      title: "Que piada",
      _class: "font-bold",
      bar: true
    ).with_content("O bagulho chato para caralho."))

    assert_selector("h3.font-bold", text: "Que piada")
    assert_selector("span.pl-3", text: "O bagulho chato para caralho.")
    assert_css ".-max-2.bg-gray-500.opacity-50.rotate-12"
  end

  test "should create a title with content component without bar" do
    render_inline(TitleWithContentComponent.new(
      title: "Que piada",
      _class: "font-bold"
    ).with_content("O bagulho chato para caralho."))

    assert_selector("h3.font-bold", text: "Que piada")
    assert_selector("span.pl-3", text: "O bagulho chato para caralho.")
    assert_no_css ".-max-2.bg-gray-500.opacity-50.rotate-12"
  end

  test "should create a title with content component without content" do
    render_inline(TitleWithContentComponent.new(
      title: "Que piada",
      _class: "font-bold",
      bar: true
    ))

    assert_selector("h3.font-bold", text: "Que piada")
    assert_no_selector("span.pl-3", text: "O bagulho chato para caralho.")
    assert_css ".-max-2.bg-gray-500.opacity-50.rotate-12"
  end

  test "should'n create a title with content component without title" do
    exception = assert_raise(ArgumentError) do
      render_inline(TitleWithContentComponent.new(
        _class: "font-bold",
        bar: true
      ).with_content("O bagulho chato para caralho."))
    end

    assert_equal("missing keyword: :title", exception.message)
  end

  test "should'n create a title with content component without _class" do
    exception = assert_raise(ArgumentError) do
      render_inline(TitleWithContentComponent.new(
        title: "Que piada",
        bar: true
      ).with_content("O bagulho chato para caralho."))
    end

    assert_equal("missing keyword: :_class", exception.message)
  end
end

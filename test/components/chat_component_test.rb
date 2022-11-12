# frozen_string_literal: true

require "test_helper"

class ChatComponentTest < ViewComponent::TestCase
  test "should create chat component" do
    render_inline(ChatComponent.new)

    assert_text "I want to receive message from tv."
    assert_text "@"
    assert_text "Send message"
  end
end

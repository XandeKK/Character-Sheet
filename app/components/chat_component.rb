# frozen_string_literal: true

class ChatComponent < ViewComponent::Base
  def initialize(player:)
    @player = player
  end
end

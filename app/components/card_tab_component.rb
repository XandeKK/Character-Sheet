# frozen_string_literal: true

class CardTabComponent < ViewComponent::Base
  def initialize(tab:, hidden:)
    @tab = tab
    @hidden = hidden
  end

  def hidden?
    @hidden
  end

end

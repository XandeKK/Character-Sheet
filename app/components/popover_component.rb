# frozen_string_literal: true

class PopoverComponent < ViewComponent::Base
  def initialize(name:, content_popover:)
    @name = name
    @content_popover = content_popover
  end

end

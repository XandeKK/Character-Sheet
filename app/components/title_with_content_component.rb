# frozen_string_literal: true

class TitleWithContentComponent < ViewComponent::Base
  def initialize(title:, _class:, bar:false)
    @title = title
    @class = _class
    @bar = bar
  end

  private
  def have_bar?
    @bar
  end
end

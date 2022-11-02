# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  def initialize(title:, svg:, tabs:nil)
    @title = title
    @svg = svg
    @tabs = tabs
  end

  def change_title
    change_name @title
  end

  def change_name name
    name.gsub("-", " ").capitalize
  end

  def render_tabs?
    !@tabs.nil?
  end
end

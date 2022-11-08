# frozen_string_literal: true

class Dropdown::NavbarComponent < ViewComponent::Base
  def initialize(name:, paths:, new_path:, edit_path:, delete_path:)
    @name = name
    @paths = paths
    @new_path = new_path
    @edit_path = edit_path
    @delete_path = delete_path
  end
end

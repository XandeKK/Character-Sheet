# frozen_string_literal: true

class Dropdown::MenuComponent < ViewComponent::Base
  def initialize(id:, edit_path:, delete_path:)
    @id = id
    @edit_path = edit_path
    @delete_path = delete_path
  end

end

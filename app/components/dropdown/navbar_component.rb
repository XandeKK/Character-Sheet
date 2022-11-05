# frozen_string_literal: true

class Dropdown::NavbarComponent < ViewComponent::Base
  def initialize(name:, model:, collection:, show_path:, new_path:, edit_path:, delete_path:)
    @name = name
    @model = model
    @collection = collection
    @show_path = show_path
    @new_path = new_path
    @edit_path = edit_path
    @delete_path = delete_path
  end

end

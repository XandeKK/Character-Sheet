# frozen_string_literal: true

class PathfinderEdit::NotesComponent < ViewComponent::Base
  include InputHelper
  include LabelHelper
  include EditCharactersHelper
  include ButtonHelper

  def initialize(character:, form:)
    @character = character
    @form = form
  end

end

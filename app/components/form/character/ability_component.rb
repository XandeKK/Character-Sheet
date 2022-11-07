# frozen_string_literal: true

class Form::Character::AbilityComponent < ViewComponent::Base
  include LabelHelper
  include InputHelper

  def initialize(form:, name:, full_name:, action:"")
    @form = form
    @name = name
    @full_name = full_name
    @action = action
  end

end

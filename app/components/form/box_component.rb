# frozen_string_literal: true

class Form::BoxComponent < ViewComponent::Base
  def initialize(title:"", forms:[])
    @title = title
    @forms = forms
  end
end

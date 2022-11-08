# frozen_string_literal: true

class Form::BoxComponent < ViewComponent::Base
  def initialize(title:"", data:nil, main_id:nil, item_id:nil, form:, fields_for:, forms:[], add:nil)
    @title = title
    @data = data
    @main_id = main_id
    @item_id = item_id
    @forms = forms
    @add = add
    @form = form
    @fields_for = fields_for
  end
end

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

  private

  def format_field(index, length)
    if index == 0
      :left
    elsif index == length
      :right
    else
      :none
    end
  end

  def modify_id_param(item, index)
    if item[:data][:"edit-character--macros-id-param"]
      item[:data][:"edit-character--macros-id-param"] = index
    else
      item[:data][:"edit-character--item-id-param"] = index
    end
  end
end

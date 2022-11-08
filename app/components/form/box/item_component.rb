# frozen_string_literal: true

class Form::Box::ItemComponent < ViewComponent::Base
  def initialize(f:, forms:, item_id:)
    @f = f
    @forms = forms
    @item_id = item_id
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

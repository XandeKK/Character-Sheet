# frozen_string_literal: true

class Form::FieldWithLabelComponent < ViewComponent::Base
  include InputHelper
  def initialize(form:, name:, surname:nil, read_only:nil, rounded:nil,
    class_div:nil, type: :text, array:[], data:{})
    @form = form
    @name = name
    @surname = surname
    @read_only = read_only
    @rounded = rounded
    @class_div = class_div
    @type = type
    @array = array
    @data = data
  end

  private

  def read_only?
    @read_only
  end

  def rounded?
    return "" unless @rounded

    case @rounded
     when :left
      "rounded-none rounded-l-lg"
     when :right
      "rounded-none rounded-r-lg"
     when :none
       "rounded-none"
     end
  end

  def make_form
    case @type
    when :number
      make_form_number
    when :area
      make_form_area
    when :select
      make_form_select
    when :text
      make_form_text
    end
  end

  def make_form_text
    if read_only?
      @form.text_field(
        @name,
        class: "#{rounded?} #{normal_field} bg-gray-300 dark:bg-gray-700",
        readonly: "",
        data: @data
      )
    else
      @form.text_field(@name,
        class: "#{rounded?} #{normal_field} bg-gray-50 dark:bg-transparent",
        data: @data
      )
    end
  end

  def make_form_area
    if read_only?
      @form.text_area(
        @name,
        class: "#{rounded?} #{normal_field} bg-gray-300 dark:bg-gray-700",
        readonly: "",
        rows: 3,
        data: @data
      )
    else
      @form.text_area(
        @name,
        class: "#{rounded?} #{normal_field} bg-gray-50 dark:bg-transparent",
        rows: 3,
        data: @data
      )
    end
  end

  def make_form_number
    if read_only?
      @form.number_field(
        @name,
        class: "#{rounded?} #{normal_field} bg-gray-300 dark:bg-gray-700",
        readonly: "",
        data: @data
      )
    else
      @form.number_field(
        @name,
        class: "#{rounded?} #{normal_field} bg-gray-50 dark:bg-transparent",
        data: @data
      )
    end
  end

  def make_form_select
    if read_only?
      @form.select(
        @name,
        @array,
        {},
        class: "#{rounded?} #{normal_field} bg-gray-300 dark:bg-gray-700",
        readonly: "",
        data: @data
    )
    else
      @form.select(
        @name,
        @array,
        {},
        class: "#{rounded?} #{normal_field} bg-gray-50 dark:bg-zinc-800",
        data: @data
    )
    end
  end
end

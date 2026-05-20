# app/inputs/rich_text_area_input.rb
#
# Custom Formtastic input that renders an ActionText / Trix WYSIWYG editor.
#
# Zeitwerk requires the top-level constant to match the filename, so the class
# is defined at RichTextAreaInput and then aliased into Formtastic::Inputs so
# Formtastic's NamespacedClassFinder can resolve `as: :rich_text_area`.
#
# Usage in ActiveAdmin forms:
#   f.input :content, as: :rich_text_area
#
class RichTextAreaInput
  include Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      label_html <<
        # Use `template` (raw ActionView context) not `builder` (Arbre-wrapped).
        # Pass object_name so the field submits as params[:project][:content].
        template.rich_text_area(object_name, method, input_html_options)
    end
  end
end

# Make it discoverable by Formtastic's NamespacedClassFinder
Formtastic::Inputs::RichTextAreaInput = RichTextAreaInput unless
  Formtastic::Inputs.const_defined?(:RichTextAreaInput)


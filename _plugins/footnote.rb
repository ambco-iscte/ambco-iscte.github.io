# frozen_string_literal: true

# rubocop:disable Layout/LineLength

# Title: Footnote tag for Jekyll
# Author:
#   Afonso B. Caniço
#
# Description: Dynamically adds footnotes to Liquid page data.
#
# Syntax:
#   {% footnote %}
#     This is a super cool footnote!
#   {% endfootnote %}
#
#   ...
#
#   {% print_footnotes %}
#
# Example:
#   Hello world!{% footnote %}
#     Do footnotes imply the existence of headnotes?
#   {% endfootnote %}
#
#   {% print_footnotes %}
#
# Output:
#   Hello world!¹
#
#   ¹ Do footnotes imply the existence of headnotes?
module Jekyll
  def self.superscript(text, cls, self_id, target_id)
    content = "<strong>#{text}</strong>"
    code = "document.getElementById('#{target_id}').scrollIntoView({ behavior: 'smooth', block: 'center' });"
    "<sup id='#{self_id}' class='#{cls} text-primary' style='cursor: pointer;' onclick=\"#{code}\">#{content}</sup>"
  end

  # Injects tag content to "footnotes" variable and renders as a superscript reference to the corresponding footnote.
  class FootnoteDefinitionTag < Liquid::Block
    def render(context)
      text = super
      page = context.environments.first['page']

      if page['footnotes']
        page['footnotes'].push(text)
      else
        page['footnotes'] = [text]
      end

      note_index = page['footnotes'].length
      Jekyll.superscript(note_index, 'jekyll-footnote-ref', "jekyll-footnote-ref-#{note_index}", "jekyll-footnote-#{note_index}")
    end
  end

  # Prints all previously-defined footnotes.
  class FootnotePrintTag < Liquid::Tag
    def render(context)
      elements = []
      page = context.environments.first['page']

      page['footnotes']&.each&.with_index do |text, index|
        sup = Jekyll.superscript(index + 1, 'jekyll-footnote', "jekyll-footnote-#{index + 1}", "jekyll-footnote-ref-#{index + 1}")
        element = "<p>#{sup} #{text}</p>"
        elements.push(element)
      end

      elements.join(' ')
    end
  end
end
# rubocop:enable Layout/LineLength

Liquid::Template.register_tag('footnote', Jekyll::FootnoteDefinitionTag)
Liquid::Template.register_tag('print_footnotes', Jekyll::FootnotePrintTag)

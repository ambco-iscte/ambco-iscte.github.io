# frozen_string_literal: true

# Title: Footnote tag for Jekyll
# Author:
#   Afonso B. Caniço
#
# Description: Dynamically adds footnotes to Liquid page data.
#
# Syntax:
#   {% footnote This is a footnote  %}
#
#   ...
#
#   {% for footnote in footnotes %}
#     ...
#   {% endfor %}
#
# Example:
#   {% footnote %}
#     Hello world! This is my very first footnote. %}
#   {% endfootnote %}
#
#   in page.html
#
# Output / Side effect:
#   Value "footnotes" is injected into page.html containing "Hello world! This is my very first footnote.".
module Jekyll
  # Injects tag content to "footnotes" variable and renders as a superscript reference to the corresponding footnote.
  class FootnoteTag < Liquid::Block
    def render(context)
      text = super
      page = context.environments.first['page']

      note_index = 1
      if page['footnotes']
        page['footnotes'].push(text)
        note_index = page['footnotes'].length
      else
        page['footnotes'] = [text]
      end

      "<sup class=\"text-primary\"><strong>#{note_index}</strong></sup>"
    end
  end
end

Liquid::Template.register_tag('footnote', Jekyll::FootnoteTag)

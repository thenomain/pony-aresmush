module AresMUSH
  module TemplateFormatterExtensions
    def divider_with_text(text)
      template = DividerWithTextTemplate.new(text)
      template.render
    end
  end
end

module AresMUSH
  module Utils
    module TemplateFormatterExtensions
      def divider_with_text(text)
        template = DividerWithTextTemplate.new(text)
        template.render
      end
    end
  end
end

# frozen_string_literal: true

module MessagesHelper
  # CodeRay Integration
  class MarkdownRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.highlight(code, language)
    end
  end

  def coderay(text)
    text.gsub(%r{\<code( lang="(.+?)")?\>(.+?)\</code\>}m) do
      CodeRay.scan(Regexp.last_match(3), Regexp.last_match(2)).div(css: :class)
    end
  end

  def markdown(text)
    rndr = MarkdownRenderer.new(filter_html: true, hard_wrap: true)
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      lax_html_blocks: true,
      superscript: true
    }
    markdown_to_html = Redcarpet::Markdown.new(rndr, options)
    markdown_to_html.render(text).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search('//pre[@lang]').each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
end

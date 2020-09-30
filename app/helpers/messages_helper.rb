# frozen_string_literal: true
require 'rouge'
require 'rouge/plugins/redcarpet'

module MessagesHelper
  # CodeRay Integration
  class MarkdownRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.highlight(code, language)
    end
  end
  # Rouge Integration
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def block_code(code, language)
      Rouge.highlight(code, language || 'text', 'html')
    end
  end

  def coderay(text)
    text.gsub(%r{<code( lang="(.+?)")?>(.+?)</code>}m) do
      CodeRay.scan(Regexp.last_match(3), Regexp.last_match(2)).div(css: :class)
    end
  end

  def markdown(text)
    options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" }
    }

    extensions = {
      autolink: true,
      highlight: true,
      superscript: true,
      disable_indented_code_blocks: true,
      space_after_headers: true,
      fenced_code_blocks: true
    }
    # markdown_to_html.render(text).html_safe
    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def markdown_classic(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: false, filter_html: true)
    options = [
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
    ]
    
    final_res = Redcarpet::Markdown.new(renderer, *options).render(text)
    # syntax_highlighter(Redcarpet::Markdown.new(rndr, options)).html_safe
    syntax_highlighter(final_res).html_safe
  end

  def markdown_test(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: false, filter_html: true)
    options = [hard_wrap: true, filter_html: true, autolink: true, no_intraemphasis: true, fenced_code_blocks: true, gh_blockcode: true]
    syntax_highlighter(Redcarpet::Markdown.new(renderer, *options).render(text)).html_safe
  end

  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
end

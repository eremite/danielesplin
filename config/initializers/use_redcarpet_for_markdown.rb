# https://github.com/middleman/middleman/issues/456
module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require 'redcarpet'
  def render(text)
    # For list of Github Flavored Markdown options see https://gist.github.com/ralph/1300939
    renderer = Redcarpet::Render::HTML.new({
      :with_toc_data => true,
      :hard_wrap => true,
      :xhtml => true,
    })
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :tables => true,
      :autolink => true,
      :strikethrough => true,
      :space_after_headers => true,
    }
    Redcarpet::Markdown.new(renderer, options).render(text)
  end
end

module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def l(object, **options)
    return nil if object.nil?
    super
  end

end

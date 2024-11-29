module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def l(object, locale: nil, format: nil, **options)
    super if object
  end

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def timespan(from_time, to_time)
    parts = ActiveSupport::Duration.build((to_time - from_time).to_i.abs).parts
    parts.slice(:years, :months, :weeks, :days).map do |key, value|
      "#{value} #{key.to_s.singularize.pluralize(value)}"
    end.join(', ')
  end

end

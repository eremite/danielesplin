module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def date_with_significant_time(date)
    l(date == date.beginning_of_day ? date.to_date : date, format: :long)
  end

end

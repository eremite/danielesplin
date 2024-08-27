module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def timespan(from_time, to_time)
    [
      year_timespan(to_time.year - from_time.year),
      month_timespan(to_time.month - from_time.month),
      day_timespan(to_time.day - from_time.day),
    ].compact.join(', ')
  end

  private

  def year_timespan(diff)
    return if diff.zero?
    diff = diff.abs
    "#{diff} #{'year'.pluralize(diff)}"
  end

  def month_timespan(diff)
    return if diff.zero?
    diff = diff.abs
    "#{diff.abs} #{'month'.pluralize(diff)}"
  end

  def day_timespan(diff)
    return if diff.zero?
    diff = diff.abs
    "#{diff.abs} #{'day'.pluralize(diff)}"
  end

end

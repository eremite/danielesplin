module ApplicationHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def date_with_significant_time(date)
    if date == date.beginning_of_day
      l(date.to_date, format: :long)
    else
      l(date, format: :long)
    end
  end

end

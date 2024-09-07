require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'timespan' do
    assert_equal '1 year', timespan(Time.local(2023, 9, 5), Time.local(2024, 9, 5))
    assert_equal '2 months', timespan(Time.local(2000, 3, 1), Time.local(2000, 5, 1))
    assert_equal '3 days', timespan(3.days.ago, Time.current)
    assert_equal '2 years, 2 days', timespan(Time.local(2005, 5, 2), Time.local(2007, 5, 5))
    assert_equal '2 years, 2 months, 4 weeks', timespan(Time.local(2005, 4, 3), Time.local(2007, 7, 2))
    assert_equal '5 years, 1 month, 2 days', timespan(Time.local(2000, 1, 1), Time.local(2005, 2, 2))
    assert_equal '1 day', timespan(Time.local(2025, 5, 5), Time.local(2025, 5, 4))
  end

end

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'timespan' do
    assert_equal '1 year', timespan(Time.zone.local(2023, 9, 5), Time.zone.local(2024, 9, 5))
    assert_equal '2 months', timespan(Time.zone.local(2000, 3, 1), Time.zone.local(2000, 5, 1))
    assert_equal '3 days', timespan(3.days.ago, Time.current)
    assert_equal '2 years, 2 days', timespan(Time.zone.local(2005, 5, 2), Time.zone.local(2007, 5, 5))
    assert_equal '2 years, 2 months, 4 weeks', timespan(Time.zone.local(2005, 4, 3), Time.zone.local(2007, 7, 2))
    assert_equal '5 years, 1 month, 2 days', timespan(Time.zone.local(2000, 1, 1), Time.zone.local(2005, 2, 2))
    assert_equal '1 day', timespan(Time.zone.local(2025, 5, 5), Time.zone.local(2025, 5, 4))
  end
end

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'timespan' do
    assert_equal '1 year', timespan(1.year.ago, Time.current)
    assert_equal '2 months', timespan(2.months.ago, Time.current)
    assert_equal '3 days', timespan(3.days.ago, Time.current)
    assert_equal '2 years, 2 days', timespan((2.years + 2.days).ago, Time.current)
    assert_equal '2 years, 3 months', timespan((2.years + 3.months).ago, Time.current)
    assert_equal '4 years, 1 month, 1 day', timespan((4.years + 1.month + 1.day).ago, Time.current)
    assert_equal '1 day', timespan(6.days.ago, 1.week.ago)
    assert_equal '1 day', timespan(1.week.ago, 6.days.ago)
  end

end

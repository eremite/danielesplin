require 'test_helper'

class PhotoSearchTest < ActiveSupport::TestCase

  test 'self.order_options' do
    assert_equal %i[at_desc created_at_desc updated_at_desc], PhotoSearch.order_options.map(&:last)
  end

  test 'load ends_on' do
    assert_equal Date.new(2030, 1, 31), PhotoSearch.new(ends_on: '2030-01-31').load.ends_on
    assert_equal Date.current, PhotoSearch.new(ends_on: 'invalid').load.ends_on
  end

  test 'load photos' do
    photo = photos(:base)
    photo.update_columns(at: 1.week.ago)
    assert_includes PhotoSearch.new.load.photos, photo
  end

end

require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'valid' do
    assert comments(:base).valid?
  end

  test 'emails notification on create' do
    assert_difference -> { ActionMailer::Base.deliveries.size } do
      Comment.create!({
        user: users(:base),
        entry: entries(:base),
        body: 'Body',
      })
    end
  end

end

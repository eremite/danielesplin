require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  test 'comment_notification' do
    Notifier.comment_notification(comments(:base)).deliver_now
    assert ActionMailer::Base.deliveries.present?
  end

end

require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  test 'comment_notification' do
    Notifier.comment_notification(comments(:base)).deliver
    assert ActionMailer::Base.deliveries.present?
  end

end

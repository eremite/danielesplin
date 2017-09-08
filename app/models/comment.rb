class Comment < ApplicationRecord

  belongs_to :post
  belongs_to :user

  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }
  scope :created_at_asc, -> { order(arel_table[:created_at].asc) }

  after_create :send_comment_notification
  validates :body, presence: true

  private

  def send_comment_notification
    Notifier.comment_notification(self).deliver_now
  end

end

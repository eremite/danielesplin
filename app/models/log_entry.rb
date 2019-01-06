class LogEntry < ApplicationRecord

  belongs_to :user

  scope :logins, -> { where(action: 'login') }
  scope :blogs, -> { where(action: 'blog') }
  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }

end

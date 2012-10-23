class LogEntry < ActiveRecord::Base

  attr_protected :id

  belongs_to :user

  scope :logins, where(action: 'login')
  scope :created_at_desc, order(arel_table[:created_at].desc)

end

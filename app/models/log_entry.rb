class LogEntry < ActiveRecord::Base

  attr_protected :id

  belongs_to :user

  scope :logins, where(action: 'login')

end

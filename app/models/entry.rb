class Entry < ActiveRecord::Base

  attr_accessible :at, :body, :public

  belongs_to :user

  validates :body, presence: true

  scope :oldest_first, order(arel_table[:at].asc)

end
class Comment < ActiveRecord::Base

  attr_accessible :body, :entry_id

  belongs_to :entry
  belongs_to :user

  scope :created_at_desc, order(arel_table[:created_at].desc)
  scope :created_at_asc, order(arel_table[:created_at].asc)

  validates :body, presence: true

end

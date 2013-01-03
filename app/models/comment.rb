class Comment < ActiveRecord::Base

  attr_accessible :body, :entry_id

  belongs_to :entry
  belongs_to :user

  validates :body, presence: true

end

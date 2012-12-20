class Thought < ActiveRecord::Base

  attr_accessible :user_id, :body, :on

  belongs_to :user

  validates :on, presence: true
  validates :user, presence: true
  validates :body, presence: true

end

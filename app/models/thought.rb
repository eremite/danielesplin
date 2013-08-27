class Thought < ActiveRecord::Base

  belongs_to :user

  validates :on, presence: true
  validates :user, presence: true
  validates :body, presence: true

end

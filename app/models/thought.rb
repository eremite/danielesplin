class Thought < ApplicationRecord

  belongs_to :user

  validates :on, presence: true
  validates :user, presence: true
  validates :body, presence: true

end

class Entry < ActiveRecord::Base

  attr_accessible :at, :body, :public

  belongs_to :user

  validates :body, presence: true

end

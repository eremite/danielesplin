class Entry < ActiveRecord::Base

  attr_accessible :at, :body, :public

  belongs_to :user

  validate :body, presence: true

end

class Entry < ActiveRecord::Base

  attr_accessible :at, :body, :public

  belongs_to :user

  validates :body, presence: true

  scope :at_desc, order(arel_table[:at].desc)
  scope :public, where(public: true)
  scope :private, where(public: false)

end

class Entry < ActiveRecord::Base

  attr_accessible :at, :body, :public

  belongs_to :user
  has_many :comments

  validates :body, presence: true

  scope :at_desc, order(arel_table[:at].desc)
  scope :public, where(public: true)
  scope :private, where(public: false)


  def title
    body.split(/\r?\n/).first.gsub(/[^\w\s\.\?,!]/, '').squish.first(50)
  end

  def photos
    t = Photo.arel_table
    conditions = t[:at].in(at.beginning_of_day..at.end_of_day).and(t[:entry_id].eq(nil))
    conditions = conditions.or(t[:entry_id].eq(id))
    Photo.where(conditions)
  end

end

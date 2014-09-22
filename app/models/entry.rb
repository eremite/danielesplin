class Entry < ActiveRecord::Base

  acts_as_taggable_on :entry_tags

  belongs_to :user

  validates :body, presence: true

  paginates_per 30

  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }

end

class BabyLog < ActiveRecord::Base

  KINDS = %w(feeding wet_diaper dirty_diaper)

  attr_accessible :user_id, :at, :kind, :notes

  belongs_to :user

  validates :user_id, presence: true
  validates :kind, inclusion: { in: KINDS }

  scope :kind, lambda { |k| where(kind: k) }
  scope :at_asc, order(arel_table[:at].asc)

end

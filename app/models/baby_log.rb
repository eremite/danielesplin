class BabyLog < ActiveRecord::Base

  KINDS = %w(feeding wet_diaper poopy_diaper)

  attr_accessible :user_id, :at, :kind, :notes

  belongs_to :user

  validates :user_id, presence: true
  validates :kind, inclusion: { in: KINDS }

  scope :kind, lambda { |k| where(kind: k) }

end

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, default: -> { Current.user }

  scope :created_at_desc, -> { order(arel_table[:created_at].desc) }
  scope :created_at_asc, -> { order(arel_table[:created_at].asc) }

  validates :body, presence: true

end

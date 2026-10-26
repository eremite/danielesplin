class Lesson < ApplicationRecord

  belongs_to :user

  scope :answered, -> { where.not(body: nil) }
  scope :liked, -> { where.not(liked_at: nil) }
  scope :questionable, -> { where(body: nil).where.not(question: nil) }

  def dismissed?
    dismissed_at.present?
  end

end

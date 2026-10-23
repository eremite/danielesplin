class Lesson < ApplicationRecord

  belongs_to :user

  scope :questionable, -> { where(body: nil).where.not(question: nil) }
  scope :answered, -> { where.not(body: nil) }

  def dismissed?
    dismissed_at.present?
  end

end

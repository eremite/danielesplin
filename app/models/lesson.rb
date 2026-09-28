class Lesson < ApplicationRecord

  belongs_to :user

  def dismissed?
    dismissed_at.present?
  end

end

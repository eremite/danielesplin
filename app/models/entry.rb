class Entry < ActiveRecord::Base

  acts_as_taggable_on :entry_tags

  belongs_to :user

  validates :body, presence: true

  paginates_per 30

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }

  def after_create_redirect_url
    if at < 1.week.ago
      [:new, :entry, { at: at + 1.day }]
    elsif user.try(:father?)
      [:entries, { user_id: User.where(role: 'mother').first.try(:id) }]
    elsif %w(mother baby).include?(user.try(:role))
      child = nil
      User.where(role: 'baby').each do |user|
        if user.entries.where(at: at.beginning_of_day..at.end_of_day).blank?
          child = user and break
        end
      end
      if child.present?
        [:new, :entry, { entry: { user_id: child.id } }]
      else
        [:entries, { user_id: User.where(role: 'father').first.try(:id) }]
      end
    else
      [:entries]
    end
  end

end

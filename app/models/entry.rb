class Entry < ApplicationRecord

  acts_as_taggable_on :entry_tags

  belongs_to :user

  validates :body, presence: true

  paginates_per 7

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'entry_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def after_create_redirect_url
    if at < 1.week.ago
      [:new, :entry, { at: at + 1.day }]
    elsif %w(mother baby).include?(user.try(:role))
      child = nil
      User.where(role: 'baby').each do |user|
        if user.entries.where(at: at.beginning_of_day..at.end_of_day).blank?
          child = user and break
        end
      end
      child.present? ? [:new, :entry, { entry: { user_id: child.id } }] : [:entries]
    else
      [:entries]
    end
  end

  def suggested_tags
    self.class.tags.where.not(id: entry_tag_ids)
  end

end

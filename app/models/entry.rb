class Entry < ApplicationRecord

  acts_as_taggable_on :entry_tags

  belongs_to :user
  belongs_to :creator, class_name: 'User', optional: true

  validates :body, presence: true, on: :update

  paginates_per 7

  scope :at_asc, -> { order(arel_table[:at].asc) }
  scope :at_desc, -> { order(arel_table[:at].desc) }
  scope :before, -> (ends_at) { where(arel_table[:at].lteq(ends_at)) }

  def self.tags
    taggings = ActsAsTaggableOn::Tagging.where(context: 'entry_tags')
    ActsAsTaggableOn::Tag.joins(:taggings).merge(taggings).order(taggings_count: :desc).distinct
  end

  def after_create_redirect_url
    return [:entries] unless at.to_date == Date.current
    if creator.parent?
      child = nil
      User.where(role: 'baby').each do |user|
        if user.entries.where(at: Time.current.all_day).blank?
          entry = Entry.create!(at: Time.current, user: user, creator: creator)
          return [:edit, entry]
        end
      end
    end
    [:entries, { on_this_day: 1 }]
  end

  def suggested_tags
    self.class.tags.where.not(id: entry_tag_ids)
  end

end
